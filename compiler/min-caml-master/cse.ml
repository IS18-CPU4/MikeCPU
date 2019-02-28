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
    | FAbs(x) -> FAbs(c_find x alpha_env)
    | FSqrt(x) -> FSqrt(c_find x alpha_env)
    | ItoF(x) -> ItoF(c_find x alpha_env)
    | FtoI(x) -> FtoI(c_find x alpha_env)


let rec deepest = function (* 副作用があるかどうかとeの最後の式を返す *)
  | Unit
  | Int(_)
  | Float(_)
  | Neg(_)
  | Add(_)
  | Sub(_)
  | LShift(_)
  | RShift(_)
  | FNeg(_)
  | FAdd(_)
  | FSub(_)
  | FMul(_)
  | FDiv(_)
  | FAbs(_)
  | FSqrt(_)
  | ItoF(_)
  | FtoI(_)
  | Var(_)
  | Tuple(_)
  | ExtArray(_) as e -> (false, e)
  (* 副作用の可能性あり or 副作用 *)
  | App(_) (* 関数適用は中身で使われるかもだからスルー *)
  | Get(_) (* ここも怪しい常に同じものをGetするとは限らない *)
  | Put(_)
  | ExtFunApp(_) as e -> (true, e)
  (* 調査次第 *)
  | IfEq(x, y, e1, e2) -> let (bool_e1, e1') = deepest e1 in
                          let (bool_e2, e2') = deepest e2 in
                            (bool_e1 || bool_e2, IfEq(x, y, e1', e2')) (* bool = trueならそもそも式自体を（関数gでは）使わない *)
  | IfLE(x, y, e1, e2) -> let (bool_e1, e1') = deepest e1 in
                          let (bool_e2, e2') = deepest e2 in
                            (bool_e1 || bool_e2, IfLE(x, y, e1', e2'))
  | Let((x, t), e1, e2) -> let (bool_e1, e1') = deepest e1 in
                           let (bool_e2, e2') = deepest e2 in
                            (bool_e1 || bool_e2, e2') (* in最後の部分が欲しい *)
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let (bool_e1, e1') = deepest e1 in
      let (bool_e2, e2') = deepest e2 in
        (bool_e1 || bool_e2, e2') (* そもそも関数適用するならApp(_)でtrue返ってくるというね *)
  | LetTuple(xts, y, e) -> deepest e




let rec g env alpha_env = function (* cseルーチン本体 *)
  | Unit -> Unit
  | Int(i) -> Int(i)
  | Float(d) -> Float(d)
(*
  | Neg(x) -> let parsed = parse (Neg(x)) alpha_env in
              let found = c_find parsed env in
                if (parsed = found) then Neg(x) else found (* parsed が env にないなら parsed = found *)
  | Add(x, y) -> let parsed = parse (Add(x, y)) alpha_env in
                 let found = c_find parsed env in
                   if (parsed = found) then Add(x, y) else found
  | Sub(x, y) -> let parsed = parse (Sub(x, y)) alpha_env in
                 let found = c_find parsed env in
                   if (parsed = found) then Sub(x, y) else found
  | LShift(x, y) -> let parsed = parse (LShift(x, y)) alpha_env in
                 let found = c_find parsed env in
                   if (parsed = found) then LShift(x, y) else found
  | RShift(x, y) -> let parsed = parse (RShift(x, y)) alpha_env in
                 let found = c_find parsed env in
                   if (parsed = found) then RShift(x, y) else found

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
*)
  | Neg(_)
  | Add(_)
  | Sub(_)
  | LShift(_)
  | RShift(_)
  | FNeg(_)
  | FAdd(_)
  | FSub(_)
  | FMul(_)
  | FDiv(_)
  | FAbs(_)
  | FSqrt(_)
  | ItoF(_)
  | FtoI(_) as e -> let parsed = parse e alpha_env in
                    let found = c_find parsed env in
                      if (parsed = found) then parsed else found   (* parsed が env にないなら parsed = found *)
  | Var(_)
  | App(_) (* 関数適用は中身で参照使われるかもだからスルー *)
  | Tuple(_)
  | Get(_)
  | Put(_)
  | ExtArray(_)
  | ExtFunApp(_) as e -> parse e alpha_env

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
      let e1' = g env alpha_env e1 in
      let (is_unit, deep) = deepest e1' in (* is_unit : e1'内に副作用があるか, deep : e1'の最後(ネストされたた場合の最後のin以降) *)
      let x' = if List.mem_assoc deep env then (* deepがenvにあった *)
                 let e = c_find deep env in
                 (match e with
                  | Var(id) -> id (* envにあったdeepと同じ式の変数 *)
                  | _ -> failwith("Not Var in cse"))
               else
                 parser x e1 in (* parserするだけ *)
      let new_alpha_env = if (x = x') then alpha_env else (Format.eprintf "modify %s@. to %s@." x x'; c_add x x' alpha_env) in
      if is_unit then
        Let((x', t), e1', g env new_alpha_env e2) (* 副作用の可能性があったらparserするだけ *)
      else
        if List.mem_assoc deep env then
          g env new_alpha_env e2 (* 共通部分の定義しなくていい *)
        else
          let new_env = c_add deep (Var(x')) env in (* 自身を追加 *)
          Let((x', t), e1', g new_env new_alpha_env e2)
(*
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
                 if (parsed = found) then csed else found)
(* (*successed*)
      Let((x, t), g env new_e1, g new_env e2)
*)
*)
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
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
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g env alpha_env e)
(*
  | Var(x) -> Var(x)
  | App(x, ys) -> App(x, ys) (* 関数適用は中身で参照使われるかもだからスルー *)
  | Tuple(xs) -> Tuple(xs)
  | Get(x, y) -> Get(x, y)
  | Put(x, y, z) -> Put(x, y, z)
  | ExtArray(x) -> ExtArray(x)
  | ExtFunApp(x, ys) -> ExtFunApp(x, ys)
*)




let f = g [] []
