(* give names to intermediate values (K-normalization) *)

let find x env = try M.find x env with Not_found -> failwith ("Not_found " ^ x)

type t = (* K正規化後の式 (caml2html: knormal_t) *)
  | Unit
  | Int of int
  | Float of float
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | LShift of Id.t * Id.t
  | RShift of Id.t * Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | IfEq of Id.t * Id.t * t * t (* 比較 + 分岐 (caml2html: knormal_branch) *)
  | IfLE of Id.t * Id.t * t * t (* 比較 + 分岐 *)
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of fundef * t
  | App of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t
  | ExtFunApp of Id.t * Id.t list
(* Library *)
  | FAbs of Id.t
  | FSqrt of Id.t
  | ItoF of Id.t
  | FtoI of Id.t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

let rec fv = function (* 式に出現する（自由な）変数 (caml2html: knormal_fv) *)
  | Unit | Int(_) | Float(_) | ExtArray(_) -> S.empty
  | Neg(x) | FNeg(x) -> S.singleton x
  | Add(x, y) | Sub(x, y) | LShift(x, y) | RShift(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(x, y, e1, e2) | IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let zs = S.diff (fv e1) (S.of_list (List.map fst yts)) in
      S.diff (S.union zs (fv e2)) (S.singleton x)
  | App(x, ys) -> S.of_list (x :: ys)
  | Tuple(xs) | ExtFunApp(_, xs) -> S.of_list xs
  | Put(x, y, z) -> S.of_list [x; y; z]
  | LetTuple(xs, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xs)))
  | FAbs(x) | FSqrt(x) | ItoF(x) | FtoI(x) -> S.singleton x

let insert_let (e, t) k = (* letを挿入する補助関数 (caml2html: knormal_insert) *)
  match e with
  | Var(x) -> k x
  | _ ->
      let x = Id.gentmp t in
      let e', t' = k x in
      Let((x, t), e, e'), t'

let rec log2 n = (* intのlog2をとる *)
  if n = 1 then 0
  else 1 + log2 (n/2)

let log2_e = function (* Int(n)のlog2をとる *)
  | Syntax2.Int(i) -> Syntax2.Int(log2 i)
  | e -> e

let rec g env = function (* K正規化ルーチン本体 (caml2html: knormal_g) *)
  | Syntax2.Unit -> Unit, Type.Unit
  | Syntax2.Bool(b) -> Int(if b then 1 else 0), Type.Int (* 論理値true, falseを整数1, 0に変換 (caml2html: knormal_bool) *)
  | Syntax2.Int(i) -> Int(i), Type.Int
  | Syntax2.Float(d) -> Float(d), Type.Float
  | Syntax2.Not(e) -> g env (Syntax2.If(e, Syntax2.Bool(false), Syntax2.Bool(true)))
  | Syntax2.Neg(e) ->
      insert_let (g env e)
        (fun x -> Neg(x), Type.Int)
  | Syntax2.Add(e1, e2) -> (* 足し算のK正規化 (caml2html: knormal_add) *)
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Add(x, y), Type.Int))
  | Syntax2.Sub(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Sub(x, y), Type.Int))
  | Syntax2.Mul(e1, e2) -> (* 掛け算（シフト）のK正規化 (caml2html: knormal_add) *)
      insert_let (g env e1)
        (fun x -> insert_let (g env (log2_e e2))
            (fun y -> LShift(x, y), Type.Int))
  | Syntax2.Div(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env (log2_e e2))
            (fun y -> RShift(x, y), Type.Int))
  | Syntax2.FNeg(e) ->
      insert_let (g env e)
        (fun x -> FNeg(x), Type.Float)
  | Syntax2.FAdd(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FAdd(x, y), Type.Float))
  | Syntax2.FSub(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FSub(x, y), Type.Float))
  | Syntax2.FMul(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FMul(x, y), Type.Float))
  | Syntax2.FDiv(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FDiv(x, y), Type.Float))
  | Syntax2.Eq _ | Syntax2.LE _ as cmp ->
      g env (Syntax2.If(cmp, Syntax2.Bool(true), Syntax2.Bool(false)))
  | Syntax2.If(Syntax2.Not(e1), e2, e3) -> g env (Syntax2.If(e1, e3, e2)) (* notによる分岐を変換 (caml2html: knormal_not) *)
  | Syntax2.If(Syntax2.Eq(e1, e2), e3, e4) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y ->
              let e3', t3 = g env e3 in
              let e4', t4 = g env e4 in
              IfEq(x, y, e3', e4'), t3))
  | Syntax2.If(Syntax2.LE(e1, e2), e3, e4) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y ->
              let e3', t3 = g env e3 in
              let e4', t4 = g env e4 in
              IfLE(x, y, e3', e4'), t3))
  | Syntax2.If(e1, e2, e3) ->
     (match g_fless_feq env e1 with
      | Syntax2.Not _
      | Syntax2.LE _
      | Syntax2.Eq _ as cmp -> g env (Syntax2.If(cmp, e2, e3)) (* fless, feq が外部関数として呼ばれた時の特殊処理 *)
      | _ -> g env (Syntax2.If(Syntax2.Eq(e1, Syntax2.Bool(false)), e3, e2))) (* 比較のない分岐を変換 (caml2html: knormal_if) *)
  | Syntax2.Let((x, t), e1, e2) ->
      let e1', t1 = g env e1 in
      let e2', t2 = g (M.add x t env) e2 in
      Let((x, t), e1', e2'), t2
  | Syntax2.Var(x) when M.mem x env -> Var(x), find x env
  | Syntax2.Var(x) -> (* 外部配列の参照 (caml2html: knormal_extarray) *)
      (match find x !Typing.extenv with
      | Type.Array(_) as t -> ExtArray x, t
      | _ -> failwith (Printf.sprintf "external variable %s does not have an array type" x))
  | Syntax2.LetRec({ Syntax2.name = (x, t); Syntax2.args = yts; Syntax2.body = e1 }, e2) ->
      let env' = M.add x t env in
      let e2', t2 = g env' e2 in
      let e1', t1 = g (M.add_list yts env') e1 in
      LetRec({ name = (x, t); args = yts; body = e1' }, e2'), t2
  | Syntax2.App(Syntax2.Var(f), e2s) when not (M.mem f env) -> (* 外部関数の呼び出し (caml2html: knormal_extfunapp) *)
      (match (try M.find f !Typing.extenv with Not_found -> if f = "create_array" then Type.Fun([Type.Unit], Type.Unit) else failwith("ext fun "^f^" Not found")) with
      | Type.Fun(_, t) ->
        (* 特殊な外部関数 *)
        if f = "create_array" then
          if List.length e2s = 2 then
            let e1 = List.hd e2s in
            let e2 = List.nth e2s 1 in
              g env (Syntax2.Array(e1, e2))
          else
            failwith(f ^ " needs only 2 args!!!")
        else if f = "fless" || f = "fequal" then
          if List.length e2s = 2 then
            let e1 = List.hd e2s in
            let e2 = List.nth e2s 1 in
            if f = "fless" then
              g env (Syntax2.Not (Syntax2.LE(e2, e1)))
            else
              g env (Syntax2.Eq(e1, e2))
          else
            failwith(f ^ " needs only 2 args!!!")
        else if f = "fneg" || f = "fhalf" || f = "fabs" || f = "abs_float" || f = "fsqr" || f = "sqrt" || f = "floor" then
          (* inline化 *)
          if List.length e2s = 1 then
            let e1 = List.hd e2s in
              if f = "fneg" then
                g env (Syntax2.FNeg(e1))
              else if f = "fhalf" then
                g env (Syntax2.FMul(e1, Syntax2.Float(0.5)))
              else if f = "fabs" || f = "abs_float" then
                insert_let (g env e1)
                  (fun x -> FAbs(x), t)
              else if f = "fsqr" then
                g env (Syntax2.FMul(e1, e1))
              else if f = "sqrt" then
                insert_let (g env e1)
                  (fun x -> FSqrt(x), t)
              else (* if f = "floor" then *) (* floor x = float_of_int(int_of_float(x -. 0.5)) *)
                insert_let (g env (Syntax2.FSub(e1, Syntax2.Float(0.5))))
                  (fun x -> insert_let (FtoI(x), Type.Int)
                    (fun y -> ItoF(y), Type.Float))
          else
            failwith(f ^ " needs only 1 args!!!")
        else if f = "int_of_float" || f = "float_of_int" || f = "truncate"(* = int_of_float *) then
          if List.length e2s = 1 then
            let e1 = List.hd e2s in
            if f = "float_of_int" then
              insert_let (g env e1)
                (fun x -> ItoF(x), t)
            else
              insert_let (g env e1)
                (fun x -> FtoI(x), t)
          else
            failwith(f ^ " needs only 1 args!!!")
        else
          let rec bind xs = function (* "xs" are identifiers for the arguments *)
            | [] ->
(*****
                (* 特殊な外部関数 *)
                if f = "create_array" then
                  if List.length e2s = 2 then
                    let e1 = List.hd e2s in
                    let e2 = List.nth e2s 1 in
                      g env (Syntax2.Array(e1, e2))
                  else
                    failwith(f ^ " needs only 2 args!!!")
                else if f = "fless" || f = "fequal" then
                  if List.length e2s = 2 then
                    let e1 = List.hd e2s in
                    let e2 = List.nth e2s 1 in
                    if f = "fless" then
                      g env (Syntax2.Not (Syntax2.LE(e2, e1)))
                    else
                      g env (Syntax2.Eq(e1, e2))
                  else
                    failwith(f ^ " needs only 2 args!!!")
                else if f = "fneg" || f = "fhalf" || f = "fabs" || f = "abs_float" || f = "fsqr" || f = "sqrt" || f = "floor" then
                  (* inline化 *)
                  if List.length e2s = 1 then
(*                    let e1 = List.hd e2s in *)
                    let x = List.hd xs in
                      if f = "fneg" then
(*                        g env (Syntax2.FNeg(e1)) *)
                        if t = Type.Float then
                          FNeg(x), t
                        else
                          failwith(f ^ " is type fun float -> float")
                      else if f = "fhalf" then
                        if t = Type.Float then
                          g env (Syntax2.FMul(Syntax2.Var(x), Syntax2.Float(0.5)))
                        else
                          failwith(f ^ " is type fun float -> float")
                      else if f = "fabs" || f = "abs_float" then
(*                        insert_let (g env e1)
                          (fun x -> FAbs(x), t) (* t = Type.Floatである必要がある *) *)
                          if t = Type.Float then
                            FAbs(x), t
                          else
                            failwith(f ^ " is type fun float -> float")
                      else if f = "fsqr" then
                        g env (Syntax2.FMul(Syntax2.Var(x), Syntax2.Var(x)))
                      else if f = "sqrt" then
(*                        insert_let (g env e1)
                          (fun x -> FSqrt(x), t) *)
                        if t = Type.Float then
                          FSqrt(x), t
                        else
                          failwith(f ^ " is type fun float -> float")
                      else (* if f = "floor" then *) (* floor x = float_of_int(int_of_float(x -. 0.5)) *)
                        if t = Type.Float then
                          insert_let (g env (Syntax2.FSub(Var(x), Syntax2.Float(0.5))))
                            (fun x -> insert_let (FtoI(x), Type.Int)
                              (fun y -> ItoF(y), Type.Float))
                        else
                          failwith(f ^ " is type fun float -> float")
                  else
                    failwith(f ^ " needs only 1 args!!!")
                else if f = "int_of_float" || f = "float_of_int" || f = "truncate"(* = int_of_float *) then
                  if List.length e2s = 1 then
(*                    let e1 = List.hd e2s in *)
                    let x = List.hd xs in
                    if f = "float_of_int" then
(*                      insert_let (g env e1)
                        (fun x -> ItoF(x), t) *)
                      if t = Type.Float then
                        ItoF(x), t
                      else
                        failwith(f ^ " is type fun int -> float")
                    else
(*                      insert_let (g env e1)
                        (fun x -> FtoI(x), t) *)
                      if t = Type.Int then
                        FtoI(x), t
                      else
                        failwith(f ^ " is type fun float -> int")
                  else
                    failwith(f ^ " needs only 1 args!!!")
                else
*****)
                  ExtFunApp(f, xs), t
            | e2 :: e2s ->
                insert_let (g env e2)
                  (fun x -> bind (xs @ [x]) e2s) in
          bind [] e2s (* left-to-right evaluation *)
      | _ -> assert false)
  | Syntax2.App(e1, e2s) ->
      (match g env e1 with
      | _, Type.Fun(_, t) as g_e1 ->
          insert_let g_e1
            (fun f ->
              let rec bind xs = function (* "xs" are identifiers for the arguments *)
                | [] -> App(f, xs), t
                | e2 :: e2s ->
                    insert_let (g env e2)
                      (fun x -> bind (xs @ [x]) e2s) in
              bind [] e2s) (* left-to-right evaluation *)
      | _ -> assert false)
  | Syntax2.Tuple(es) ->
      let rec bind xs ts = function (* "xs" and "ts" are identifiers and types for the elements *)
        | [] -> Tuple(xs), Type.Tuple(ts)
        | e :: es ->
            let _, t as g_e = g env e in
            insert_let g_e
              (fun x -> bind (xs @ [x]) (ts @ [t]) es) in
      bind [] [] es
  | Syntax2.LetTuple(xts, e1, e2) ->
      insert_let (g env e1)
        (fun y ->
          let e2', t2 = g (M.add_list xts env) e2 in
          LetTuple(xts, y, e2'), t2)
  | Syntax2.Array(e1, e2) ->
      insert_let (g env e1)
        (fun x ->
          let _, t2 as g_e2 = g env e2 in
          insert_let g_e2
            (fun y ->
              let l =
                match t2 with
                | Type.Float -> "create_float_array"
                | _ -> "create_array" in
              ExtFunApp(l, [x; y]), Type.Array(t2)))
  | Syntax2.Get(e1, e2) ->
      (match g env e1 with
      |        _, Type.Array(t) as g_e1 ->
          insert_let g_e1
            (fun x -> insert_let (g env e2)
                (fun y -> Get(x, y), t))
      | _ -> assert false)
  | Syntax2.Put(e1, e2, e3) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> insert_let (g env e3)
                (fun z -> Put(x, y, z), Type.Unit)))

and g_fless_feq env = function
  | Syntax2.App(Syntax2.Var(f), e2s) when not (M.mem f env) -> (* 外部関数の呼び出し (caml2html: knormal_extfunapp) *)
      (match (try find f !Typing.extenv with Not_found -> if f = "create_array" then Type.Fun([Type.Unit], Type.Unit) else failwith("ext fun "^f^" Not found")) with
       | Type.Fun(_, t) ->
         if f = "fless" || f = "fequal" then
           if List.length e2s = 2 then
             let e1 = List.hd e2s in
             let e2 = List.nth e2s 1 in
             if f = "fless" then
               Syntax2.Not (Syntax2.LE(e2, e1))
             else
               Syntax2.Eq(e1, e2)
           else
             failwith(f ^ " needs only 2 args!!!")
         else
           Syntax2.App(Syntax2.Var(f), e2s)
       | e -> Syntax2.App(Syntax2.Var(f), e2s))
  | e -> e

let f e = fst (g M.empty e)
