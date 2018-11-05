(* 課題１、KNormal.t表示用 *)
open PrintSyntax

let kn_tab = ref 0

let rec print_knormal_t knormal =
  match knormal with
    | KNormal.Unit -> let _ = print_tab !kn_tab in print_endline "UNIT"
    | KNormal.Int i -> let _ = print_tab !kn_tab in
                       let _ = print_string "INT " in
                       let _ = print_int i in print_newline ()
    | KNormal.Float f -> let _ = print_tab !kn_tab in
                         let _ = print_string "FLOAT " in
                         let _ = print_float f in print_newline ()
    | KNormal.Neg id -> let _ = print_tab !kn_tab in
                        let _ = print_endline "NEG" in
                        let _ = (kn_tab := !kn_tab + 1) in
                        let _ = print_tab !kn_tab in
                        let _ = print_endline id in
                          kn_tab := !kn_tab - 1
    | KNormal.Add (id1, id2) -> let _ = print_tab !kn_tab in
                                let _ = print_endline "ADD" in
                                let _ = (kn_tab := !kn_tab + 1) in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id1 in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id2 in
                                  kn_tab := !kn_tab - 1
    | KNormal.Sub (id1, id2) -> let _ = print_tab !kn_tab in
                                let _ = print_endline "SUB" in
                                let _ = (kn_tab := !kn_tab + 1) in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id1 in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id2 in
                                  kn_tab := !kn_tab - 1
    | KNormal.LShift (id1, id2) -> let _ = print_tab !kn_tab in
                                let _ = print_endline "LSHIFT" in
                                let _ = (kn_tab := !kn_tab + 1) in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id1 in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id2 in
                                  kn_tab := !kn_tab - 1
    | KNormal.RShift (id1, id2) -> let _ = print_tab !kn_tab in
                                let _ = print_endline "RSHIFT" in
                                let _ = (kn_tab := !kn_tab + 1) in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id1 in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id2 in
                                  kn_tab := !kn_tab - 1
    | KNormal.FNeg id -> let _ = print_tab !kn_tab in
                         let _ = print_endline "FNEG" in
                         let _ = (kn_tab := !kn_tab + 1) in
                         let _ = print_tab !kn_tab in
                         let _ = print_endline id in
                           kn_tab := !kn_tab - 1
    | KNormal.FAdd (id1, id2) -> let _ = print_tab !kn_tab in
                                 let _ = print_endline "FADD" in
                                 let _ = (kn_tab := !kn_tab + 1) in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id1 in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id2 in
                                   kn_tab := !kn_tab - 1
    | KNormal.FSub (id1, id2) -> let _ = print_tab !kn_tab in
                                 let _ = print_endline "FSUB" in
                                 let _ = (kn_tab := !kn_tab + 1) in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id1 in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id2 in
                                   kn_tab := !kn_tab - 1
    | KNormal.FMul (id1, id2) -> let _ = print_tab !kn_tab in
                                 let _ = print_endline "FMUL" in
                                 let _ = (kn_tab := !kn_tab + 1) in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id1 in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id2 in
                                   kn_tab := !kn_tab - 1
    | KNormal.FDiv (id1, id2) -> let _ = print_tab !kn_tab in
                                 let _ = print_endline "FDIV" in
                                 let _ = (kn_tab := !kn_tab + 1) in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id1 in
                                 let _ = print_tab !kn_tab in
                                 let _ = print_endline id2 in
                                   kn_tab := !kn_tab - 1
    | KNormal.IfEq (id1, id2, t1, t2) -> let _ = print_tab !kn_tab in
                                         let _ = print_endline "IFEQ" in
                                         let _ = (kn_tab := !kn_tab + 1) in
                                         let _ = print_tab !kn_tab in
                                         let _ = print_endline id1 in
                                         let _ = print_tab !kn_tab in
                                         let _ = print_endline id2 in
                                         let _ = print_knormal_t t1 in
                                         let _ = print_knormal_t t2 in
                                           kn_tab := !kn_tab - 1
    | KNormal.IfLE (id1, id2, t1, t2) -> let _ = print_tab !kn_tab in
                                         let _ = print_endline "IFLE" in
                                         let _ = (kn_tab := !kn_tab + 1) in
                                         let _ = print_tab !kn_tab in
                                         let _ = print_endline id1 in
                                         let _ = print_tab !kn_tab in
                                         let _ = print_endline id2 in
                                         let _ = print_knormal_t t1 in
                                         let _ = print_knormal_t t2 in
                                           kn_tab := !kn_tab - 1
    | KNormal.Let ((id, ty), t1, t2) -> let _ = print_tab !kn_tab in
                                           let _ = print_endline "LET" in
                                           let _ = (kn_tab := !kn_tab + 1) in
                                           let _ = print_tab !kn_tab in
                                           let _ = print_string (id ^ " ") in
                                           let _ = print_type ty in
                                           let _ = print_knormal_t t1 in
                                           let _ = kn_tab := !kn_tab - 1 in
                                           let _ = print_tab !kn_tab in
                                           let _ = print_endline "IN" in
                                           let _ = kn_tab := !kn_tab + 1 in
                                           let _ = print_knormal_t t2 in
                                             kn_tab := !kn_tab - 1
    | KNormal.Var id -> let _ = print_tab !kn_tab in print_endline ("VAR " ^ id)
    | KNormal.LetRec (fundef, t) -> let _ = print_tab !kn_tab in
                                    let _ = print_endline "LETREC" in
                                    let _ = (kn_tab := !kn_tab + 1) in
                                    let _ = print_knormal_fundef fundef in
                                    let _ = (kn_tab := !kn_tab + 1) in
                                    let _ = print_knormal_t t in
                                      kn_tab := !kn_tab - 2
    | KNormal.App (id, id_list) -> let _ = print_tab !kn_tab in
                                   let _ = print_endline "APP" in
                                   let _ = (kn_tab := !kn_tab + 1) in
                                   let _ = print_tab !kn_tab in
                                   let _ = print_endline id in
                                   let _ = print_id_list id_list in
                                     kn_tab := !kn_tab - 1
    | KNormal.Tuple id_list -> let _ = print_tab !kn_tab in
                               let _ = print_endline "TUPLE" in
                               let _ = (kn_tab := !kn_tab + 1) in
                               let _ = print_id_list id_list in
                                 kn_tab := !kn_tab - 1
    | KNormal.LetTuple (id_type_list, id, t) -> let _ = print_tab !kn_tab in
                                                let _ = print_endline "LETTUPLE" in
                                                let _ = (kn_tab := !kn_tab + 1) in
                                                let _ = print_id_type_list id_type_list in
                                                let _ = print_tab !kn_tab in
                                                let _ = print_endline id in
                                                let _ = print_knormal_t t in
                                                  kn_tab := !kn_tab - 1
    | KNormal.Get (id1, id2) -> let _ = print_tab !kn_tab in
                                let _ = print_endline "FDIV" in
                                let _ = (kn_tab := !kn_tab + 1) in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id1 in
                                let _ = print_tab !kn_tab in
                                let _ = print_endline id2 in
                                  kn_tab := !kn_tab - 1
    | KNormal.Put (id1, id2, id3) -> let _ = print_tab !kn_tab in
                                     let _ = print_endline "FDIV" in
                                     let _ = (kn_tab := !kn_tab + 1) in
                                     let _ = print_tab !kn_tab in
                                     let _ = print_endline id1 in
                                     let _ = print_tab !kn_tab in
                                     let _ = print_endline id2 in
                                     let _ = print_tab !kn_tab in
                                     let _ = print_endline id3 in
                                       kn_tab := !kn_tab - 1
    | KNormal.ExtArray id -> let _ = print_tab !kn_tab in
                             let _ = print_endline "EXTARRAY" in
                             let _ = (kn_tab := !kn_tab + 1) in
                             let _ = print_tab !kn_tab in
                             let _ = print_endline id in
                               kn_tab := !kn_tab - 1
    | KNormal.ExtFunApp (id, id_list) -> let _ = print_tab !kn_tab in
                                         let _ = print_endline "EXTARRAY" in
                                         let _ = (kn_tab := !kn_tab + 1) in
                                         let _ = print_tab !kn_tab in
                                         let _ = print_endline id in
                                         let _ = print_id_list id_list in
                                           kn_tab := !kn_tab - 1
and print_knormal_fundef fundef = (* KNormal.fundef型の標準出力 *)
  let {KNormal.name = (id, ty); KNormal.args = args_list; KNormal.body = normal} = fundef in
  let _ = print_tab !kn_tab in
  let _ = print_string (id ^ " ") in
  let _ = print_type ty in
  let syntax_tab = !PrintSyntax.tab in
  let _ = PrintSyntax.tab := !kn_tab in
  let _ = print_id_type_list args_list in
  let _ = print_knormal_t normal in
    PrintSyntax.tab := syntax_tab
and print_id_list id_list =
  match id_list with
    | [] -> print_string ""
    | id::ys -> let _ = print_tab !kn_tab in
                let _ = print_endline id in
                  print_id_list ys
