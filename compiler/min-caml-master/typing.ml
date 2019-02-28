(* type inference/reconstruction *)

open Syntax

exception Unify of Type.t * Type.t
exception Error of t * Type.t * Type.t * int * int * int
exception ShiftError of t * int * int * int

let extenv = ref M.empty

(* for pretty printing (and type normalization) *)
let rec deref_typ = (function (* 型変数を中身でおきかえる関数 (caml2html: typing_deref) *)
  | Type.Fun(t1s, t2) -> Type.Fun(List.map deref_typ t1s, deref_typ t2)
  | Type.Tuple(ts) -> Type.Tuple(List.map deref_typ ts)
  | Type.Array(t) -> Type.Array(deref_typ t)
  | Type.Var({ contents = None } as r) ->
      Format.eprintf "uninstantiated type variable detected; assuming int@.";
      r := Some(Type.Int);
      Type.Int
  | Type.Var({ contents = Some(t) } as r) ->
      let t' = deref_typ t in
      r := Some(t');
      t'
  | t -> t :Type.t -> Type.t)

let rec deref_id_typ (x, t) = (x, deref_typ t)
let rec deref_term = function
  | Not(e, line, start, t_end) -> Not(deref_term e, line, start, t_end)
  | Neg(e, line, start, t_end) -> Neg(deref_term e, line, start, t_end)
  | Add(e1, e2, line, start, t_end) -> Add(deref_term e1, deref_term e2, line, start, t_end)
  | Sub(e1, e2, line, start, t_end) -> Sub(deref_term e1, deref_term e2, line, start, t_end)
  | Mul(e1, e2, line, start, t_end) -> Mul(deref_term e1, deref_term e2, line, start, t_end)
  | Div(e1, e2, line, start, t_end) -> Div(deref_term e1, deref_term e2, line, start, t_end)
  | Eq(e1, e2, line, start, t_end) -> Eq(deref_term e1, deref_term e2, line, start, t_end)
  | LE(e1, e2, line, start, t_end) -> LE(deref_term e1, deref_term e2, line, start, t_end)
  | FNeg(e, line, start, t_end) -> FNeg(deref_term e, line, start, t_end)
  | FAdd(e1, e2, line, start, t_end) -> FAdd(deref_term e1, deref_term e2, line, start, t_end)
  | FSub(e1, e2, line, start, t_end) -> FSub(deref_term e1, deref_term e2, line, start, t_end)
  | FMul(e1, e2, line, start, t_end) -> FMul(deref_term e1, deref_term e2, line, start, t_end)
  | FDiv(e1, e2, line, start, t_end) -> FDiv(deref_term e1, deref_term e2, line, start, t_end)
  | If(e1, e2, e3, line, start, t_end) -> If(deref_term e1, deref_term e2, deref_term e3, line, start, t_end)
  | Let(xt, e1, e2, line, start, t_end) -> Let(deref_id_typ xt, deref_term e1, deref_term e2, line, start, t_end)
  | LetRec({ name = xt; args = yts; body = e1 }, e2, line, start, t_end) ->
      LetRec({ name = deref_id_typ xt;
               args = List.map deref_id_typ yts;
               body = deref_term e1 },
             deref_term e2, line, start, t_end)
  | App(e, es, line, start, t_end) -> App(deref_term e, List.map deref_term es, line, start, t_end)
  | Tuple(es, line, start, t_end) -> Tuple(List.map deref_term es, line, start, t_end)
  | LetTuple(xts, e1, e2, line, start, t_end) -> LetTuple(List.map deref_id_typ xts, deref_term e1, deref_term e2, line, start, t_end)
  | Array(e1, e2, line, start, t_end) -> Array(deref_term e1, deref_term e2, line, start, t_end)
  | Get(e1, e2, line, start, t_end) -> Get(deref_term e1, deref_term e2, line, start, t_end)
  | Put(e1, e2, e3, line, start, t_end) -> Put(deref_term e1, deref_term e2, deref_term e3, line, start, t_end)
  | e -> e

let rec occur r1 = (function (* occur check (caml2html: typing_occur) *)
  | Type.Fun(t2s, t2) -> List.exists (occur r1) t2s || occur r1 t2
  | Type.Tuple(t2s) -> List.exists (occur r1) t2s
  | Type.Array(t2) -> occur r1 t2
  | Type.Var(r2) when r1 == r2 -> true
  | Type.Var({ contents = None }) -> false
  | Type.Var({ contents = Some(t2) }) -> occur r1 t2
  | _ -> false : Type.t -> bool)

let rec unify (t1: Type.t) (t2: Type.t) = (* 型が合うように、型変数への代入をする (caml2html: typing_unify) *)
  match t1, t2 with
  | Type.Unit, Type.Unit | Type.Bool, Type.Bool | Type.Int, Type.Int | Type.Float, Type.Float -> ()
  | Type.Fun(t1s, t1'), Type.Fun(t2s, t2') ->
      (try List.iter2 unify t1s t2s
      with Invalid_argument(_) -> raise (Unify(t1, t2)));
      unify t1' t2'
  | Type.Tuple(t1s), Type.Tuple(t2s) ->
      (try List.iter2 unify t1s t2s
      with Invalid_argument(_) -> raise (Unify(t1, t2)))
  | Type.Array(t1), Type.Array(t2) -> unify t1 t2
  | Type.Var(r1), Type.Var(r2) when r1 == r2 -> ()
  | Type.Var({ contents = Some(t1') }), _ -> unify t1' t2
  | _, Type.Var({ contents = Some(t2') }) -> unify t1 t2'
  | Type.Var({ contents = None } as r1), _ -> (* 一方が未定義の型変数の場合 (caml2html: typing_undef) *)
      if occur r1 t2 then raise (Unify(t1, t2));
      r1 := Some(t2)
  | _, Type.Var({ contents = None } as r2) ->
      if occur r2 t1 then raise (Unify(t1, t2));
      r2 := Some(t1)
  | _, _ -> raise (Unify(t1, t2))


let rec is_2 n = (* nが2**kか？ *)
  if n = 1 then
    true
  else if n mod 2 = 0 then
    is_2 (n / 2)
  else
    false

let is_int_2 e = (* eがInt(2**n)か？ *)
  match e with
   | Int(n,_,_,_) -> is_2 n
   | _ -> false

let rec g env e = (* 型推論ルーチン (caml2html: typing_g) Syntax.t -> Type.t *)
  try
    match e with
    | Unit(line, start, t_end) -> Type.Unit
    | Bool(_, line, start, t_end) -> Type.Bool
    | Int(_, line, start, t_end) -> Type.Int
    | Float(_, line, start, t_end) -> Type.Float
    | Not(e, line, start, t_end) ->
        unify Type.Bool (g env e);
        Type.Bool
    | Neg(e, line, start, t_end) ->
        unify Type.Int (g env e);
        Type.Int
    | Add(e1, e2, line, start, t_end) | Sub(e1, e2, line, start, t_end) -> (* ­足し算（と引き算）の型推論 (caml2html: typing_add) *)
        unify Type.Int (g env e1);
        unify Type.Int (g env e2);
        Type.Int
    | Mul(e1, e2, line, start, t_end) | Div(e1, e2, line, start, t_end) ->
        unify Type.Int (g env e1);
        unify Type.Int (g env e2);
(*        if is_int_2 e2 then (* e2が即値の２のべき乗か？ *) *)
          Type.Int
(*        else
          raise (ShiftError(deref_term e, line, start, t_end)) *)
    | FNeg(e, line, start, t_end) ->
        unify Type.Float (g env e);
        Type.Float
    | FAdd(e1, e2, line, start, t_end) | FSub(e1, e2, line, start, t_end) | FMul(e1, e2, line, start, t_end) | FDiv(e1, e2, line, start, t_end) ->
        unify Type.Float (g env e1);
        unify Type.Float (g env e2);
        Type.Float
    | Eq(e1, e2, line, start, t_end) | LE(e1, e2, line, start, t_end) ->
        unify (g env e1) (g env e2);
        Type.Bool
    | If(e1, e2, e3, line, start, t_end) ->
        unify (g env e1) Type.Bool;
        let t2 = g env e2 in
        let t3 = g env e3 in
        unify t2 t3;
        t2
    | Let((x, t), e1, e2, line, start, t_end) -> (* letの型推論 (caml2html: typing_let) *)
        unify t (g env e1);
        g (M.add x t env) e2
    | Var(x, line, start, t_end) when M.mem x env -> M.find x env (* 変数の型推論 (caml2html: typing_var) *)
    | Var(x, line, start, t_end) when M.mem x !extenv -> M.find x !extenv
    | Var(x, line, start, t_end) -> (* 外部変数の型推論 (caml2html: typing_extvar) *)
        Format.eprintf "free variable %s assumed as external@." x;
        let t = Type.gentyp () in
        (if not (x = "create_array") then
          if x = "fneg" || x = "fhalf" || x = "fabs" || x = "abs_float" || x = "fsqr" || x = "sqrt" || x = "floor" || x = "sin" || x = "cos" || x = "atan" then
            extenv := M.add x (Type.Fun([Type.Float], Type.Float)) !extenv
          else if x = "fless" || x = "fequal" then
            extenv := M.add x (Type.Fun([Type.Float;Type.Float], Type.Bool)) !extenv
          else if x = "int_of_float" || x = "truncate" then
            extenv := M.add x (Type.Fun([Type.Float], Type.Int)) !extenv
          else if x = "float_of_int" then
            extenv := M.add x (Type.Fun([Type.Int], Type.Float)) !extenv
          else
            extenv := M.add x t !extenv
        else
          Format.eprintf "%s" x
        );
        t
    | LetRec({ name = (x, t); args = yts; body = e1 }, e2, line, start, t_end) -> (* let recの型推論 (caml2html: typing_letrec) *)
        let env = M.add x t env in
        unify t (Type.Fun(List.map snd yts, g (M.add_list yts env) e1));
        g env e2
    | App(e, es, line, start, t_end) -> (* 関数適用の型推論 (caml2html: typing_app) *)
        (match e with
          | Var(f, _, _, _) when f = "create_array" && not (M.mem f env) && not (M.mem f !extenv) -> (* 外部変数としての関数create_arrayと認識 -> 型多相 *)
                  if (List.length es = 2) then
                    let e1 = List.hd es in
                    let e2 = List.nth es 1 in
                      unify (g env e1) Type.Int;
                      Type.Array(g env e2)
                  else
                    failwith("create_array needs 2 args !!!")
          | _ -> let t = Type.gentyp () in
                 unify (g env e) (Type.Fun(List.map (g env) es, t));
                 t)
    | Tuple(es, line, start, t_end) -> Type.Tuple(List.map (g env) es)
    | LetTuple(xts, e1, e2, line, start, t_end) ->
        unify (Type.Tuple(List.map snd xts)) (g env e1);
        g (M.add_list xts env) e2
    | Array(e1, e2, line, start, t_end) -> (* must be a primitive for "polymorphic" typing *)
        unify (g env e1) Type.Int;
        Type.Array(g env e2)
    | Get(e1, e2, line, start, t_end) ->
        let t = Type.gentyp () in
        unify (Type.Array(t)) (g env e1);
        unify Type.Int (g env e2);
        t
    | Put(e1, e2, e3, line, start, t_end) ->
        let t = g env e3 in
        unify (Type.Array(t)) (g env e1);
        unify Type.Int (g env e2);
        Type.Unit
  with Unify(t1, t2) ->
         let (line, start, t_end) = get_pos e in
          raise (Error(deref_term e, deref_typ t1, deref_typ t2, line, start, t_end))




let f e =
  extenv := M.empty;
(*
  (match deref_typ (g M.empty e) with
  | Type.Unit -> ()
  | _ -> Format.eprintf "warning: final result does not have type unit@.");
*)
  (try unify Type.Unit (g M.empty e)
  with Unify _ -> failwith "top level does not have type unit");
  extenv := M.map deref_typ !extenv;
  deref_term e
