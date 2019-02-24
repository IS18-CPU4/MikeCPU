(* asm.t表示用 *)
open PrintSyntax

let asm_tab = ref 0

let rec print_asm_t asm =
  match asm with
    | Asm.Ans (exp) -> print_asm_exp exp true
    | Asm.Let ((id, ty), exp, t) -> let _ = print_tab !asm_tab in
                                    let _ = print_string (id ^ " := ") in
                                    let _ = print_asm_exp exp false in
                                      print_asm_t t
and print_asm_exp exp need_tab =
  let _ = if need_tab then print_tab !asm_tab in
  match exp with
    | Asm.Nop -> print_endline ("Nop")
    | Asm.Li (i) -> print_endline (string_of_int(i))
    | Asm.FLi (Id.L(fl_label)) -> print_endline ("FLi " ^ fl_label)
    | Asm.SetL (Id.L(label)) -> print_endline ("SetL " ^ label)
    | Asm.Mr (id) -> print_endline ("Mr " ^ id)
    | Asm.Neg (id) -> print_endline ("-" ^ id)
    | Asm.Add (id, id_or_imm) -> print_endline (id ^ " + " ^ (id_or_imm_to_string id_or_imm))
    | Asm.Sub (id, id_or_imm) -> print_endline (id ^ " - " ^ (id_or_imm_to_string id_or_imm))
    | Asm.Slw (id, id_or_imm) -> print_endline (id ^ " << " ^ (id_or_imm_to_string id_or_imm))
    | Asm.Srw (id, id_or_imm) -> print_endline (id ^ " >> " ^ (id_or_imm_to_string id_or_imm))
    | Asm.Lwz (id, id_or_imm) -> print_endline ("Ld " ^ id ^
                                                  " " ^ (id_or_imm_to_string id_or_imm))
    | Asm.Stw (id, id2, id_or_imm) -> print_endline ("St " ^ id ^
                                                       " " ^ id2 ^
                                                       " " ^ (id_or_imm_to_string id_or_imm))
    | Asm.FMr (id) -> print_endline ("FMr " ^ id)
    | Asm.FNeg (id) -> print_endline ("-" ^ id)
    | Asm.FAdd (id1, id2) -> print_endline (id1 ^ " +. " ^ id2)
    | Asm.FSub (id1, id2) -> print_endline (id1 ^ " -. " ^ id2)
    | Asm.FMul (id1, id2) -> print_endline (id1 ^ " *. " ^ id2)
    | Asm.FDiv (id1, id2) -> print_endline (id1 ^ " /. " ^ id2)
    | Asm.Lfd (id, id_or_imm) -> print_endline ("Lfd " ^ id ^
                                                     " " ^ (id_or_imm_to_string id_or_imm))
    | Asm.Stfd (id, id2, id_or_imm) -> print_endline ("Stfd " ^ id ^
                                                            " " ^ id2 ^
                                                            " " ^ (id_or_imm_to_string id_or_imm))
    | Asm.FAbs (id) -> print_endline ("FAbs " ^ id)
    | Asm.FSqrt (id) -> print_endline ("FSqrt " ^ id)
    | Asm.ItoF (id) -> print_endline ("ItoF " ^ id)
    | Asm.FtoI (id) -> print_endline ("FtoI " ^ id)    
    | Asm.Comment (str) -> print_endline ("# " ^ str)
    (* virtual instructions *)
    | Asm.IfEq (id, id_or_imm, asm1, asm2) -> let _ = print_endline ("IfEq " ^ id ^
                                                                         " " ^ (id_or_imm_to_string id_or_imm)) in
                                              let _ = asm_tab := !asm_tab + 1 in
                                              let _ = print_asm_t asm1 in
                                              let _ = asm_tab := !asm_tab - 1 in
                                              let _ = print_tab !asm_tab in
                                              let _ = print_endline ("Else") in
                                              let _ = asm_tab := !asm_tab + 1 in
                                              let _ = print_asm_t asm2 in
                                                asm_tab := !asm_tab - 1
    | Asm.IfLE (id, id_or_imm, asm1, asm2) -> let _ = print_endline ("IfLE " ^ id ^
                                                                         " " ^ (id_or_imm_to_string id_or_imm)) in
                                              let _ = asm_tab := !asm_tab + 1 in
                                              let _ = print_asm_t asm1 in
                                              let _ = asm_tab := !asm_tab - 1 in
                                              let _ = print_tab !asm_tab in
                                              let _ = print_endline ("Else") in
                                              let _ = asm_tab := !asm_tab + 1 in
                                              let _ = print_asm_t asm2 in
                                                asm_tab := !asm_tab - 1
    | Asm.IfGE (id, id_or_imm, asm1, asm2) -> let _ = print_endline ("IfGE " ^ id ^
                                                                         " " ^ (id_or_imm_to_string id_or_imm)) in
                                              let _ = asm_tab := !asm_tab + 1 in
                                              let _ = print_asm_t asm1 in
                                              let _ = asm_tab := !asm_tab - 1 in
                                              let _ = print_tab !asm_tab in
                                              let _ = print_endline ("Else") in
                                              let _ = asm_tab := !asm_tab + 1 in
                                              let _ = print_asm_t asm2 in
                                                asm_tab := !asm_tab - 1
    | Asm.IfFEq (id1, id2, asm1, asm2) -> let _ = print_endline ("IfFEq " ^ id1 ^
                                                                      " " ^ id2) in
                                          let _ = asm_tab := !asm_tab + 1 in
                                          let _ = print_asm_t asm1 in
                                          let _ = asm_tab := !asm_tab - 1 in
                                          let _ = print_tab !asm_tab in
                                          let _ = print_endline ("Else") in
                                          let _ = asm_tab := !asm_tab + 1 in
                                          let _ = print_asm_t asm2 in
                                            asm_tab := !asm_tab - 1
    | Asm.IfFLE (id1, id2, asm1, asm2) -> let _ = print_endline ("IfFLE " ^ id1 ^
                                                                      " " ^ id2) in
                                          let _ = asm_tab := !asm_tab + 1 in
                                          let _ = print_asm_t asm1 in
                                          let _ = asm_tab := !asm_tab - 1 in
                                          let _ = print_tab !asm_tab in
                                          let _ = print_endline ("Else") in
                                          let _ = asm_tab := !asm_tab + 1 in
                                          let _ = print_asm_t asm2 in
                                            asm_tab := !asm_tab - 1
    (* closure address, integer arguments, and float arguments *)
(*
    | Asm.CallCls (fun_name, int_args, float_args) -> let _ = print_endline ("CallCls " ^ fun_name) in
                                                      let _ = asm_tab := !asm_tab + 1 in
                                                      let _ = print_tab !asm_tab in
                                                      let _ = print_endline ("IntArgs : " ^ id_list_to_string int_args) in
                                                      let _ = print_tab !asm_tab in
                                                      let _ = print_endline ("FloatArgs : " ^ id_list_to_string float_args) in
                                                        asm_tab := !asm_tab - 1
    | Asm.CallDir (Id.L(fun_name), int_args, float_args) -> let _ = print_endline ("CallDir " ^ fun_name) in
                                                            let _ = asm_tab := !asm_tab + 1 in
                                                            let _ = print_tab !asm_tab in
                                                            let _ = print_endline ("IntArgs : " ^ id_list_to_string int_args) in
                                                            let _ = print_tab !asm_tab in
                                                            let _ = print_endline ("FloatArgs : " ^ id_list_to_string float_args) in
                                                              asm_tab := !asm_tab - 1
*)
    | Asm.CallCls (fun_name, int_args, float_args) -> print_endline ("CallCls " ^ fun_name ^
                                                                            "(" ^ id_list_to_string int_args ^
                                                                            " " ^ id_list_to_string float_args ^ ")")
    | Asm.CallDir (Id.L(fun_name), int_args, float_args) -> print_endline ("CallCls " ^ fun_name ^
                                                                                "(" ^ id_list_to_string int_args ^
                                                                                " " ^ id_list_to_string float_args ^ ")")
    | Asm.Save (id1, id2) (* レジスタ変数の値をスタック変数へ保存 (caml2html: sparcasm_save) *)
        -> print_endline ("Save " ^ id1 ^ " " ^ id2)
    | Asm.Restore (id) (* スタック変数から値を復元 (caml2html: sparcasm_restore) *)
        -> print_endline ("Restore " ^ id)
and id_or_imm_to_string id_or_imm =
  match id_or_imm with
    | Asm.V(id) -> id
    | Asm.C(i) -> string_of_int(i)
and id_list_to_string id_list =
  match id_list with
    | [] -> ""
    | id::ids -> id ^ " " ^ (id_list_to_string ids)

let rec print_label_float_list idl_float_list =
  match idl_float_list with
    | [] -> ()
    | (Id.L(label), fl)::lists -> let _ = print_endline (label ^ " " ^ string_of_float fl) in
                              print_label_float_list lists
let rec print_asm_fundef_list fundef_list =
  match fundef_list with
    | [] -> ()
    | fundef::lists
      -> let { Asm.name = Id.L(label); Asm.args = args_list; Asm.fargs = fargs_list; Asm.body = asm_t; Asm.ret = ty } = fundef in
         let _ = print_tab !asm_tab in
         let _ = print_endline (label ^ " :") in
         let _ = asm_tab := !asm_tab + 1 in
         let _ = print_tab !asm_tab in
         let _ = print_endline ("IntArgs : " ^ id_list_to_string args_list) in
         let _ = print_tab !asm_tab in
         let _ = print_endline ("FloatArgs : " ^ id_list_to_string fargs_list) in
         let _ = print_asm_t asm_t in
         let _ = asm_tab := !asm_tab - 1 in
           print_asm_fundef_list lists

let print_asm_prog prog =
  let Asm.Prog (idl_float_list, fundef_list, asm_t) = prog in
  let _ = print_label_float_list idl_float_list in
  let _ = print_asm_fundef_list fundef_list in
    print_asm_t asm_t
