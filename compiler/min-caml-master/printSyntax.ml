(*課題１、Syntax.t表示用*)
let tab = ref 0

let rec print_tab n =
  if n = 0 then
    print_string ""
  else
    let _ = print_string "  " in
    print_tab (n - 1)

let rec print_syntax_t syntax = (* Syntax.t型の標準出力 *)
  match syntax with
  | Syntax.Unit -> let _ = print_tab !tab in print_endline "UNIT"
  | Syntax.Bool b -> let _ = print_tab !tab in
                     if b then print_endline "BOOL TRUE" else print_endline "BOOL FALSE"
  | Syntax.Int n -> let _ = print_tab !tab in
                    let _ = print_string "INT " in
                    let _ = print_int n in print_newline ()
  | Syntax.Float f -> let _ = print_tab !tab in
                      let _ = print_string "FLOAT " in
                      let _ = print_float f in print_newline ()
  | Syntax.Not t -> let _ = print_tab !tab in
                    let _ = print_endline "NOT" in
                    let _ = (tab := !tab + 1) in
                    let _ = print_syntax_t t in
                      tab := !tab - 1
  | Syntax.Neg t -> let _ = print_tab !tab in
                    let _ = print_endline "NEG" in
                    let _ = (tab := !tab + 1) in
                    let _ = print_syntax_t t in
                      tab := !tab - 1
  | Syntax.Add (t1, t2) -> let _ = print_tab !tab in
                           let _ = print_endline "ADD" in
                           let _ = (tab := !tab + 1) in
                           let _ = print_syntax_t t1 in
                           let _ = print_syntax_t t2 in
                            tab := !tab - 1
  | Syntax.Sub (t1, t2) -> let _ = print_tab !tab in
                           let _ = print_endline "SUB" in
                           let _ = (tab := !tab + 1) in
                           let _ = print_syntax_t t1 in
                           let _ = print_syntax_t t2 in
                            tab := !tab - 1
  | Syntax.Mul (t1, t2) -> let _ = print_tab !tab in
                           let _ = print_endline "MUL" in
                           let _ = (tab := !tab + 1) in
                           let _ = print_syntax_t t1 in
                           let _ = print_syntax_t t2 in
                            tab := !tab - 1
  | Syntax.Div (t1, t2) -> let _ = print_tab !tab in
                           let _ = print_endline "DIV" in
                           let _ = (tab := !tab + 1) in
                           let _ = print_syntax_t t1 in
                           let _ = print_syntax_t t2 in
                            tab := !tab - 1

  | Syntax.FNeg t -> let _ = print_tab !tab in
                     let _ = print_endline "FNEG" in
                     let _ = (tab := !tab + 1) in
                     let _ = print_syntax_t t in
                       tab := !tab - 1
  | Syntax.FAdd (t1, t2) -> let _ = print_tab !tab in
                            let _ = print_endline "FADD" in
                            let _ = (tab := !tab + 1) in
                            let _ = print_syntax_t t1 in
                            let _ = print_syntax_t t2 in
                             tab := !tab - 1
  | Syntax.FSub (t1, t2) -> let _ = print_tab !tab in
                            let _ = print_endline "FSUB" in
                            let _ = (tab := !tab + 1) in
                            let _ = print_syntax_t t1 in
                            let _ = print_syntax_t t2 in
                              tab := !tab - 1
  | Syntax.FMul (t1, t2) -> let _ = print_tab !tab in
                            let _ = print_endline "FMUL" in
                            let _ = (tab := !tab + 1) in
                            let _ = print_syntax_t t1 in
                            let _ = print_syntax_t t2 in
                             tab := !tab - 1
  | Syntax.FDiv (t1, t2) -> let _ = print_tab !tab in
                            let _ = print_endline "FDIV" in
                            let _ = (tab := !tab + 1) in
                            let _ = print_syntax_t t1 in
                            let _ = print_syntax_t t2 in
                             tab := !tab - 1
  | Syntax.Eq (t1, t2) -> let _ = print_tab !tab in
                          let _ = print_endline "EQ" in
                          let _ = (tab := !tab + 1) in
                          let _ = print_syntax_t t1 in
                          let _ = print_syntax_t t2 in
                           tab := !tab - 1
  | Syntax.LE (t1, t2) -> let _ = print_tab !tab in
                          let _ = print_endline "LE" in
                          let _ = (tab := !tab + 1) in
                          let _ = print_syntax_t t1 in
                          let _ = print_syntax_t t2 in
                           tab := !tab - 1
  | Syntax.If (t1, t2, t3) -> let _ = print_tab !tab in
                              let _ = print_endline "IF" in
                              let _ = (tab := !tab + 1) in
                              let _ = print_syntax_t t1 in
                              let _ = print_syntax_t t2 in
                              let _ = print_syntax_t t3 in
                                tab := !tab - 1
  | Syntax.Let ((id, ty), t1, t2) -> let _ = print_tab !tab in
                              let _ = print_endline "LET" in
                              let _ = (tab := !tab + 1) in
                              let _ = print_tab !tab in
                              let _ = print_string (id ^ " ") in
                              let _ = print_type ty in
                              let _ = print_syntax_t t1 in
                              let _ = tab := !tab - 1 in
                              let _ = print_tab !tab in
                              let _ = print_endline "IN" in
                              let _ = tab := !tab + 1 in
                              let _ = print_syntax_t t2 in
                                tab := !tab - 1
  | Syntax.Var id -> let _ = print_tab !tab in
                       print_endline ("VAR " ^ id)
  | Syntax.LetRec (fundef, t) -> let _ = print_tab !tab in
                                 let _ = print_endline "LETREC " in
                                 let _ = (tab := !tab + 1) in
                                 let _ = print_syntax_fundef fundef in
                                 let _ = print_syntax_t t in
                                   tab := !tab - 1
  | Syntax.App (t, t_list) -> let _ = print_tab !tab in
                              let _ = print_endline "APP" in
                              let _ = (tab := !tab + 1) in
                              let _ = print_syntax_t t in
                              let _ = (tab := !tab + 1) in
                              let _ = print_syntax_t_list t_list in
                                tab := !tab - 2
  | Syntax.Tuple t_list -> let _ = print_tab !tab in
                           let _ = print_endline "TUPLE" in
                           let _ = (tab := !tab + 1) in
                           let _ = print_syntax_t_list t_list in
                            tab := !tab - 1
  | Syntax.LetTuple (id_type_list, t1, t2) -> let _ = print_tab !tab in
                                              let _ = print_endline "LETTUPLE" in
                                              let _ = (tab := !tab + 1) in
                                              let _ = print_id_type_list id_type_list in
                                              let _ = print_syntax_t t1 in
                                              let _ = print_tab !tab in
                                              let _ = print_endline "IN" in
                                              let _ = print_syntax_t t2 in
                                                tab := !tab - 1
  | Syntax.Array (t1, t2) -> let _ = print_tab !tab in
                             let _ = print_endline "ARRAY" in
                             let _ = (tab := !tab + 1) in
                             let _ = print_syntax_t t1 in
                             let _ = print_syntax_t t2 in
                               tab := !tab - 1
  | Syntax.Get (t1, t2) -> let _ = print_tab !tab in
                           let _ = print_endline "GET" in
                           let _ = (tab := !tab + 1) in
                           let _ = print_syntax_t t1 in
                           let _ = print_syntax_t t2 in
                             tab := !tab - 1
  | Syntax.Put (t1, t2, t3) -> let _ = print_tab !tab in
                               let _ = print_endline "PUT" in
                               let _ = (tab := !tab + 1) in
                               let _ = print_syntax_t t1 in
                               let _ = print_syntax_t t2 in
                               let _ = print_syntax_t t3 in
                                 tab := !tab - 1
and print_syntax_t_list t_list =
  match t_list with
    | [] -> print_newline ()
    | t::ty -> let _ = print_syntax_t t in print_syntax_t_list ty
and print_syntax_fundef fundef = (* Syntax.fundef型の標準出力 *)
  let {Syntax.name = (id, ty); Syntax.args = args_list; Syntax.body = syntax} = fundef in
  let _ = print_tab !tab in
  let _ = print_string (id ^ " ") in
  let _ = print_type ty in
  let _ = print_id_type_list args_list in
    print_syntax_t syntax
and print_type ty = (* Type.t型の標準出力 *)
  match ty with
    | Type.Unit -> print_endline "UNIT"
    | Type.Bool -> print_endline "BOOL"
    | Type.Int -> print_endline "INT"
    | Type.Float -> print_endline "FLOAT"
    | Type.Fun (t_list, t) -> let _ = print_string "FUN (" in
                              let _ = print_type_list t_list in
                              let _ = print_string " -> " in
                              let _ = print_not_new_line_type t in
                                print_endline ")"
    | Type.Tuple (t_list) -> let _ = print_string "TUPLE(" in
                             let _ = print_type_list t_list in
                             let _ = print_string ")" in
                               print_newline ()
    | Type.Array t -> let _ = print_string "ARRAY(" in
                      let _ = print_not_new_line_type t in
                        print_endline ")"
    | Type.Var ({contents = None}) -> print_endline "VAR NONE"
    | Type.Var ({contents = Some (t)}) -> let _ = print_string "VAR " in print_type t
and print_not_new_line_type ty = (* print_type_list用の改行しないprint_type *)
  match ty with
    | Type.Unit -> print_string "UNIT"
    | Type.Bool -> print_string "BOOL"
    | Type.Int -> print_string "INT"
    | Type.Float -> print_string "FLOAT"
    | Type.Fun (t_list, t) -> let _ = print_string "FUN (" in
                              let _ = print_type_list t_list in
                              let _ = print_string " -> " in
                              let _ = print_not_new_line_type t in
                                print_string ")"
    | Type.Tuple (t_list) -> let _ = print_string "TUPLE(" in
                             let _ = print_type_list t_list in
                              print_string ")"
    | Type.Array t -> let _ = print_string "ARRAY(" in
                      let _ = print_not_new_line_type t in
                        print_string ")"
    | Type.Var ({contents = None}) -> print_string "VAR NONE"
    | Type.Var ({contents = Some (t)}) -> let _ = print_string "VAR " in print_not_new_line_type t
and print_type_list ty_list = (* Type.t listの標準出力 *)
  match ty_list with
    | [] -> print_string ""
    | t::[] -> print_not_new_line_type t
    | t::ty -> let _ = print_not_new_line_type t in
               let _ = print_string "," in
                 print_type_list ty
and print_id_type_list id_type_list = (* (Id.t,Type.t) list 用の標準出力 *)
  match id_type_list with
    | [] -> print_string ""
    | (id,ty)::ys -> let _ = print_tab !tab in
                     let _ = print_string (id ^ " ") in
                     let _ = print_type ty in print_id_type_list ys
