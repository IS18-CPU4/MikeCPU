(* Common subexpression elimination : 共通部分式削除 *)
open KNormal

let c_add e var env = (e, var)::env
let c_find x env = try List.assoc x env with Not_found -> x


let rec print_env env =
  match env with
    | [] -> print_newline ()
    | (var, e)::ys -> let _ = print_string("(") in
                      let _ = PrintKNormal.print_knormal_t var in
                      let _ = print_string(" ") in
                      let _ = PrintKNormal.print_knormal_t e in
                      let _ = print_endline(")") in
                        print_env ys


let rec parser x e1 = (* Tiとかの中間変数をひと纒めにする *)
  if String.length x >= 2 && String.get x 0 = 'T' then
    let id = match e1 with
              | Unit -> "()"
              | Int(i) -> string_of_int i
              | Float(d) -> string_of_float d
              | Let((y, t), e1, e2) -> parser y e1
              | _ -> ""
      in
    match String.get x 1 with
      | 'u' -> if (id = "") then x else "Tu."^id
      | 'b' -> if (id = "") then x else "Tb."^id
      | 'i' -> if (id = "") then x else "Ti."^id
      | 'd' -> if (id = "") then x else "Td."^id
      | y -> x
  else x


let rec parse x alpha_env =
  match x with
    | Unit -> Unit
    | Int(i) -> Int(i)
    | Float(d) -> Float(d)
    | Neg(x) -> Neg(c_find x alpha_env)
    | Add(x, y) -> Add(c_find x alpha_env, c_find y alpha_env)
    | Sub(x, y) -> Sub(c_find x alpha_env, c_find y alpha_env)
    | LShift(x, y) -> LShift(c_find x alpha_env, c_find y alpha_env)
    | RShift(x, y) -> RShift(c_find x alpha_env, c_find y alpha_env)
    | FNeg(x) -> FNeg(c_find x alpha_env)
    | FAdd(x, y) -> FAdd(c_find x alpha_env, c_find y alpha_env)
    | FSub(x, y) -> FSub(c_find x alpha_env, c_find y alpha_env)
    | FMul(x, y) -> FMul(c_find x alpha_env, c_find y alpha_env)
    | FDiv(x, y) -> FDiv(c_find x alpha_env, c_find y alpha_env)
    | IfEq(x, y, e1, e2) -> IfEq(c_find x alpha_env, c_find y alpha_env, parse e1 alpha_env, parse e2 alpha_env)
    | IfLE(x, y, e1, e2) -> IfLE(c_find x alpha_env, c_find y alpha_env, parse e1 alpha_env, parse e2 alpha_env)
    | Let((x, t), e1, e2) -> let x' = parser x e1 in
                             let new_alpha_env = if (x = x') then alpha_env else c_add x x' alpha_env in
                               Let((x', t), parse e1 new_alpha_env, parse e2 new_alpha_env)
    | Var(x) -> Var(c_find x alpha_env)
    | LetRec({ name = (x, t); args = yts; body = e1 }, e2) -> (* let recでも追加 *)
        LetRec({ name = (c_find x alpha_env, t); args = yts; body = parse e1 alpha_env}, parse e2 alpha_env)
    | App(x, ys) -> App(c_find x alpha_env, List.map (function i -> c_find i alpha_env) ys) (* 関数適用は中身で参照使われるかもだからスルー *)
    | Tuple(xs) -> Tuple(List.map (function i -> c_find i alpha_env) xs)
    | LetTuple(xts, y, e) -> (* LetTupleのα変換 (caml2html: alpha_lettuple) *)
        LetTuple (List.map (function (i, t) -> (c_find i alpha_env, t)) xts, c_find y alpha_env, parse e alpha_env)
    | Get(x, y) -> Get(c_find x alpha_env, c_find y alpha_env)
    | Put(x, y, z) -> Put(c_find x alpha_env, c_find y alpha_env, c_find z alpha_env)
    | ExtArray(x) -> ExtArray(c_find x alpha_env)
    | ExtFunApp(x, ys) -> ExtFunApp(c_find x alpha_env, List.map (function i -> c_find i alpha_env) ys)



let rec g env alpha_env = function (* cseルーチン本体 *)
  | Unit -> Unit
  | Int(i) -> Int(i)
  | Float(d) -> Float(d)
(*
  | Neg(x) -> c_find (Neg(x)) env
  | Add(x, y) -> c_find (Add(x, y)) env
  | Sub(x, y) -> c_find (Sub(x, y)) env
  | FNeg(x) -> c_find (FNeg(x)) env
  | FAdd(x, y) -> c_find (FAdd(x, y)) env
  | FSub(x, y) -> c_find (FSub(x, y)) env
  | FMul(x, y) -> c_find (FMul(x, y)) env
  | FDiv(x, y) -> c_find (FDiv(x, y)) env
  | IfEq(x, y, e1, e2) -> c_find (IfEq(x, y, g env e1, g env e2)) env
  | IfLE(x, y, e1, e2) -> c_find (IfLE(x, y, g env e1, g env e2)) env
*)
  | Neg(x) -> let parsed = parse (Neg(x)) alpha_env in
              let found = c_find parsed env in
                if (parsed = found) then Neg(x) else found
  | Add(x, y) -> let parsed = parse (Add(x, y)) alpha_env in
                 let found = c_find parsed env in
                   if (parsed = found) then Add(x, y) else found
  | Sub(x, y) -> let parsed = parse (Sub(x, y)) alpha_env in
                 let found = c_find parsed env in
                   if (parsed = found) then Sub(x, y) else found
  | FNeg(x) -> let parsed = parse (FNeg(x)) alpha_env in
               let found = c_find parsed env in
                 if (parsed = found) then FNeg(x) else found
  | FAdd(x, y) -> let parsed = parse (FAdd(x, y)) alpha_env in
                  let found = c_find parsed env in
                    if (parsed = found) then FAdd(x, y) else found
  | FSub(x, y) -> let parsed = parse (FSub(x, y)) alpha_env in
                  let found = c_find parsed env in
                    if (parsed = found) then FSub(x, y) else found
  | FMul(x, y) -> let parsed = parse (FMul(x, y)) alpha_env in
                  let found = c_find parsed env in
                    if (parsed = found) then FMul(x, y) else found
  | FDiv(x, y) -> let parsed = parse (FDiv(x, y)) alpha_env in
                  let found = c_find parsed env in
                    if (parsed = found) then FDiv(x, y) else found
  | IfEq(x, y, e1, e2) -> let csed = IfEq(x, y, g env alpha_env e1, g env alpha_env e2) in
                          let parsed = parse csed alpha_env in
                          let found = c_find parsed env in
                            if (parsed = found) then csed else found
  | IfLE(x, y, e1, e2) -> let csed = IfLE(x, y, g env alpha_env e1, g env alpha_env e2) in
                          let parsed = parse csed alpha_env in
                          let found = c_find parsed env in
                            if (parsed = found) then csed else found

(*
  | Neg(x) -> c_find (Neg(c_find x alpha_env)) env
  | Add(x, y) -> c_find (Add(c_find x alpha_env, c_find y alpha_env)) env
  | Sub(x, y) -> c_find (Sub(c_find x alpha_env, c_find y alpha_env)) env
  | FNeg(x) -> c_find (FNeg(c_find x alpha_env)) env
  | FAdd(x, y) -> c_find (FAdd(c_find x alpha_env, c_find y alpha_env)) env
  | FSub(x, y) -> c_find (FSub(c_find x alpha_env, c_find y alpha_env)) env
  | FMul(x, y) -> c_find (FMul(c_find x alpha_env, c_find y alpha_env)) env
  | FDiv(x, y) -> c_find (FDiv(c_find x alpha_env, c_find y alpha_env)) env
  | IfEq(x, y, e1, e2) -> c_find (IfEq(c_find x alpha_env, c_find y alpha_env, g env alpha_env e1, g env alpha_env e2)) env
  | IfLE(x, y, e1, e2) -> c_find (IfLE(c_find x alpha_env, c_find y alpha_env, g env alpha_env e1, g env alpha_env e2)) env
*)
  | Let((x, t), e1, e2) -> (* letでe1をenvに入れていく *)

      let x' = parser x e1 in
      let new_alpha_env = if (x = x') then alpha_env else c_add x x' alpha_env in
      let e1' = parse e1 new_alpha_env in (* e1の中の中間変数を全て上のparserにかけたものにする *)
      let new_e1 = g env new_alpha_env e1' in
      let new_env = if (c_find new_e1 env = new_e1) then
                      c_add new_e1 (Var(x')) env
                    else
                      env in
(*
      let _ = print_endline("env is") in
      let _ = print_env env in
*)
      let csed = Let((x, t), g env alpha_env e1, g new_env new_alpha_env e2) in
      let parsed = parse csed new_alpha_env in
      let found = c_find parsed new_env in
        if (parsed = found) then csed else found

(* (*successed*)
      Let((x, t), g env new_e1, g new_env e2)
*)
  | Var(x) -> Var(x)
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) -> (* let recでも追加 *)
      LetRec({ name = (x, t); args = yts; body = g env alpha_env e1}, g env alpha_env e2)
  (*
      let env = M.add x (Id.genid x) env in
      let ys = List.map fst yts in
      let env' = M.add_list2 ys (List.map Id.genid ys) env in
      LetRec({ name = (find x env, t);
               args = List.map (fun (y, t) -> (find y env', t)) yts;
               body = g env' e1 },
             g env e2)
             *)
  | App(x, ys) -> App(x, ys) (* 関数適用は中身で参照使われるかもだからスルー *)
  | Tuple(xs) -> Tuple(xs)
  | LetTuple(xts, y, e) -> (* LetTupleのα変換 (caml2html: alpha_lettuple) *)
      LetTuple(xts, y, g env alpha_env e)
  | Get(x, y) -> Get(x, y)
  | Put(x, y, z) -> Put(x, y, z)
  | ExtArray(x) -> ExtArray(x)
  | ExtFunApp(x, ys) -> ExtFunApp(x, ys)




let f = g [] []
