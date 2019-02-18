(* remove disused instruction : 不要命令削除 *)

let loop = 10
let search_len = 5

type t = (* 命令セット *)
  | E_Li of reg * simm_or_label
  | E_Mr of reg * reg
  | E_Addi of reg * reg * simm_or_label
  | E_Add of reg * reg * reg
  | E_Sub of reg * reg * reg
  | E_Slwi of reg * reg * int
  | E_Srwi of reg * reg * int
  | E_Slw of reg * reg * reg
  | E_Srw of reg * reg * reg
  | E_FAdd of reg * reg * reg
  | E_FSub of reg * reg * reg
  | E_FMul of reg * reg * reg
  | E_FDiv of reg * reg * reg
  | E_FMr of reg * reg
  | E_B of string
  | E_BEq of string
  | E_BNE of string
  | E_BLT of string
  | E_BL of string
  | E_BLr
  | E_Ba of reg
  | E_Bal of reg
  | E_MfLr of reg
  | E_MtLr of reg
  | E_Cmpwi of reg * reg * int (* creg * reg * simm *)
  | E_Cmpw of reg * reg * reg (* creg * reg * reg *)
  | E_FCmp of reg * reg * reg (* creg * freg * freg *)
  | E_Ld of reg * reg * int
  | E_St of reg * reg * int
  | E_FLd of reg * reg * int
  | E_FSt of reg * reg * int
  | E_Label of string
  | E_Comment of string
(*
  | FSqrt of reg * t
  | FAbs of reg * t
  | Out of reg * t
  | In of reg * t
*)
and reg = string
(*
  | Reg of int
  | CReg of int
  | FReg of int
*)
and simm_or_label =
  | Int of int
  | Ha16 of string
  | Lo16 of string

type code = t list

let rec print_each_code oc code =
  match code with
  | E_Li(reg, i_or_l) -> Printf.fprintf oc "\tli\t%s, %s\n" reg (label_to_str i_or_l)
  | E_Mr (reg1, reg2) -> Printf.fprintf oc "\tmr\t%s, %s\n" reg1 reg2
  | E_Addi (reg1, reg2, i_or_l) -> Printf.fprintf oc "\taddi\t%s, %s, %s\n" reg1 reg2 (label_to_str i_or_l)
  | E_Add (reg1, reg2, reg3) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" reg1 reg2 reg3
  | E_Sub (reg1, reg2, reg3) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" reg1 reg2 reg3
  | E_Slwi (reg1, reg2, i) -> Printf.fprintf oc "\tslwi\t%s, %s, %d\n" reg1 reg2 i
  | E_Srwi (reg1, reg2, i) -> Printf.fprintf oc "\tsrwi\t%s, %s, %d\n" reg1 reg2 i
  | E_Slw (reg1, reg2, reg3) -> Printf.fprintf oc "\tslw\t%s, %s, %s\n" reg1 reg2 reg3
  | E_Srw (reg1, reg2, reg3) -> Printf.fprintf oc "\tsrw\t%s, %s, %s\n" reg1 reg2 reg3
  | E_FAdd (reg1, reg2, reg3) -> Printf.fprintf oc "\tfadd\t%s, %s, %s\n" reg1 reg2 reg3
  | E_FSub (reg1, reg2, reg3) -> Printf.fprintf oc "\tfsub\t%s, %s, %s\n" reg1 reg2 reg3
  | E_FMul (reg1, reg2, reg3) -> Printf.fprintf oc "\tfmul\t%s, %s, %s\n" reg1 reg2 reg3
  | E_FDiv (reg1, reg2, reg3) -> Printf.fprintf oc "\tfdiv\t%s, %s, %s\n" reg1 reg2 reg3
  | E_FMr (reg1, reg2) -> Printf.fprintf oc "\tfmr\t%s, %s\n" reg1 reg2
  | E_B (str) -> Printf.fprintf oc "\tb\t%s\n" str
  | E_BEq (str) -> Printf.fprintf oc "\tbeq\t%s\n" str
  | E_BNE (str) -> Printf.fprintf oc "\tbne\t%s\n" str
  | E_BLT (str) -> Printf.fprintf oc "\tblt\t%s\n" str
  | E_BL (str) -> Printf.fprintf oc "\tbl\t%s\n" str
  | E_BLr -> Printf.fprintf oc "\tblr\n"
  | E_Ba (reg) -> Printf.fprintf oc "\tba\t%s\n" reg
  | E_Bal (reg) -> Printf.fprintf oc "\tbal\t%s\n" reg
  | E_MfLr (reg) -> Printf.fprintf oc "\tmflr\t%s\n" reg
  | E_MtLr (reg) -> Printf.fprintf oc "\tmtlr\t%s\n" reg
  | E_Cmpwi (reg1, reg2, i) -> Printf.fprintf oc "\tcmpwi\t%s, %s, %d\n" reg1 reg2 i (* creg * reg * simm *)
  | E_Cmpw (reg1, reg2, reg3) -> Printf.fprintf oc "\tcmpw\t%s, %s, %s\n" reg1 reg2 reg3 (* creg * reg * reg *)
  | E_FCmp (reg1, reg2, reg3) -> Printf.fprintf oc "\tfcmp\t%s, %s, %s\n" reg1 reg2 reg3 (* creg * freg * freg *)
  | E_Ld (reg1, reg2, i) -> Printf.fprintf oc "\tld\t%s, %s, %d\n" reg1 reg2 i
  | E_St (reg1, reg2, i) -> Printf.fprintf oc "\tst\t%s, %s, %d\n" reg1 reg2 i
  | E_FLd (reg1, reg2, i) -> Printf.fprintf oc "\tfld\t%s, %s, %d\n" reg1 reg2 i
  | E_FSt (reg1, reg2, i) -> Printf.fprintf oc "\tfst\t%s, %s, %d\n" reg1 reg2 i
  | E_Label (str) -> Printf.fprintf oc "%s:\n" str
  | E_Comment (str) -> Printf.fprintf oc "# %s\n" str
and label_to_str = function
  | Int(i) -> Printf.sprintf "%d" i
  | Ha16(label) -> Printf.sprintf "ha16(%s)" label
  | Lo16(label) -> Printf.sprintf "lo16(%s)" label

let print_code oc codes =
  List.iter (print_each_code oc) codes


(* target_regがlength以内の命令で使われ(used)ずに変更されるか(modified)) *)
let rec is_reg_modified target_reg codes length =
  if length <= 0 then
    true (* それ以降使われるかもしれない *)
  else
    match codes with
      | [] -> false
      | i :: is -> (match i with
(*
                    (* 用いられてないのに変更された！ *)
                    | E_Li (reg, _) when reg = target_reg
                    | E_Addi (reg1, reg2, _) when reg1 = target_reg && not (reg2 = target_reg)
                    | E_Slwi (reg1, reg2, _) when reg1 = target_reg && not (reg2 = target_reg)
                    | E_Srwi (reg1, reg2, _) when reg1 = target_reg && not (reg2 = target_reg)
                    | E_Slw (reg1, reg2, reg3) when reg1 = target_reg && not (reg2 = target_reg || reg3 = target_reg)
                    | E_Srw (reg1, reg2, reg3) when reg1 = target_reg && not (reg2 = target_reg || reg3 = target_reg)
                    | E_FAdd (reg1, reg2, reg3) when reg1 = target_reg && not (reg2 = target_reg || reg3 = target_reg)
                    | E_FSub (reg1, reg2, reg3) when reg1 = target_reg && not (reg2 = target_reg || reg3 = target_reg)
                    | E_FMul (reg1, reg2, reg3) when reg1 = target_reg && not (reg2 = target_reg || reg3 = target_reg)
                    | E_FDiv (reg1, reg2, reg3) when reg1 = target_reg && not (reg2 = target_reg || reg3 = target_reg)
                    | E_FMr (reg1, _) when reg1 = target_reg
                    | E_MfLr (reg) when reg = target_reg
                    | E_Ld (reg1, reg2, _) when reg1 = target_reg && not (reg2 = target_reg)
                    | E_FLd (reg1, reg2, _) when reg1 = target_reg && not (reg2 = target_reg)
                        -> false
*)
                    (* (caller-saveではあるが)jump先で使うかもしれない *)
                    | E_B (_)
                    | E_BEq (_)
                    | E_BNE (_)
                    | E_BLT (_)
                    | E_BL (_)
                    | E_BLr
                    | E_Ba (_)
                    | E_Bal (_)
                    | E_Label(_)
                        -> true
                    (* 用いた! *)
                    | E_Mr (_, reg2)
                    | E_Addi (_, reg2, _)
                    | E_Slwi (_, reg2, _)
                    | E_Srwi (_, reg2, _)
                    | E_FMr (_, reg2)
                    | E_Cmpwi (_, reg2, _) when reg2 = target_reg (* cmpのreg1はcreg *)
                      -> true
                    | E_MtLr (reg) when reg = target_reg
                      -> true
                    | E_Add (_, reg2, reg3)
                    | E_Sub (_, reg2, reg3)
                    | E_Slw (_, reg2, reg3)
                    | E_Srw (_, reg2, reg3)
                    | E_FAdd (_, reg2, reg3)
                    | E_FSub (_, reg2, reg3)
                    | E_FMul (_, reg2, reg3)
                    | E_FDiv (_, reg2, reg3)
                    | E_Cmpw (_, reg2, reg3)
                    | E_FCmp (_, reg2, reg3) when reg2 = target_reg || reg3 = target_reg
                      -> true
                    | E_Ld (reg1, reg2 , _)
                    | E_St (reg1, reg2 , _)
                    | E_FLd (reg1, reg2 , _)
                    | E_FSt (reg1, reg2 , _) when reg1 = target_reg || reg2 = target_reg
                        -> true
                    (* 用いられてないのに変更された！ *)
                    | E_Li (reg, _)
                    | E_MfLr (reg) when reg = target_reg
                      -> false
                    | E_Addi (reg1, _, _)
                    | E_Add (reg1, _, _)
                    | E_Sub (reg1, _, _)
                    | E_Slwi (reg1, _, _)
                    | E_Srwi (reg1, _, _)
                    | E_Slw (reg1, _, _)
                    | E_Srw (reg1, _, _)
                    | E_FAdd (reg1, _, _)
                    | E_FSub (reg1, _, _)
                    | E_FMul (reg1, _, _)
                    | E_FDiv (reg1, _, _)
                    | E_FMr (reg1, _)
                    | E_Ld (reg1, _, _)
                    | E_FLd (reg1, _, _) when reg1 = target_reg
                        -> false
                    | E_Comment(_) -> is_reg_modified target_reg is length
                    | _ -> is_reg_modified target_reg is (length - 1))

(* E_MtLr(target_reg)までtarget_regを用いないか。 used : 使われたか ; modified : 変更されたか*)
let rec is_mtlr target_reg codes length =
  if length <= 0 then
    false (* 用いてるかもしれない *)
  else
    match codes with
      | [] -> true
      | i :: is -> (match i with
                      (* (caller-saveではあるが)jump先で使うかもしれない *)
                      | E_B (_)
                      | E_BEq (_)
                      | E_BNE (_)
                      | E_BLT (_)
                      | E_BL (_)
                      | E_BLr
                      | E_Ba (_)
                      | E_Bal (_)
                      | E_Label(_)
                          -> false
                      (* 用いた! *)
                      | E_Mr (_, reg2)
                      | E_Addi (_, reg2, _)
                      | E_Slwi (_, reg2, _)
                      | E_Srwi (_, reg2, _)
                      | E_FMr (_, reg2)
                      | E_Cmpwi (_, reg2, _) when reg2 = target_reg (* cmpのreg1はcreg *)
                          -> false
                      | E_Add (_, reg2, reg3)
                      | E_Sub (_, reg2, reg3)
                      | E_Slw (_, reg2, reg3)
                      | E_Srw (_, reg2, reg3)
                      | E_FAdd (_, reg2, reg3)
                      | E_FSub (_, reg2, reg3)
                      | E_FMul (_, reg2, reg3)
                      | E_FDiv (_, reg2, reg3)
                      | E_Cmpw (_, reg2, reg3)
                      | E_FCmp (_, reg2, reg3) when reg2 = target_reg || reg3 = target_reg
                          -> false
                      | E_Ld (reg1, reg2 , _)
                      | E_St (reg1, reg2 , _)
                      | E_FLd (reg1, reg2 , _)
                      | E_FSt (reg1, reg2 , _) when reg1 = target_reg || reg2 = target_reg
                          -> false
                      (* 用いられてないのに変更された！ *)
                      | E_Li (reg, _) when reg = target_reg
                          -> true
                      | E_Addi (reg1, _, _)
                      | E_Add (reg1, _, _)
                      | E_Sub (reg1, _, _)
                      | E_Slwi (reg1, _, _)
                      | E_Srwi (reg1, _, _)
                      | E_Slw (reg1, _, _)
                      | E_Srw (reg1, _, _)
                      | E_FAdd (reg1, _, _)
                      | E_FSub (reg1, _, _)
                      | E_FMul (reg1, _, _)
                      | E_FDiv (reg1, _, _)
                      | E_FMr (reg1, _)
                      | E_Ld (reg1, _, _)
                      | E_FLd (reg1, _, _) when reg1 = target_reg
                          -> true
                      | E_MfLr (reg) when reg = target_reg
                          -> true
                      (* 変更及び用いてないのに使われた！ *)
                      | E_MtLr (reg) when reg = target_reg -> true
                      | E_Comment(_) -> is_mtlr target_reg is length
                      | _ -> is_mtlr target_reg is (length - 1))

(* E_MtLr(target_reg)を消す *)
let rec remove_mtlr target_reg codes search_len =
  if search_len <= 0 then
    codes
  else
    match codes with
      | [] -> []
      | i :: is -> (match i with
                    | E_MtLr (reg) when reg = target_reg -> is
                    | E_B (_)
                    | E_BEq (_)
                    | E_BNE (_)
                    | E_BLT (_)
                    | E_BL (_)
                    | E_BLr
                    | E_Ba (_)
                    | E_Bal (_)
                    | E_Label(_) -> codes
                    | E_Comment(_) as e -> e :: remove_mtlr target_reg is search_len
                    | e -> e :: remove_mtlr target_reg is (search_len-1))

let rec rdui codes = (* 不要命令消去 *)
  match codes with
    | [] -> []
    | i :: is -> match i with
                  | E_Mr (reg1, reg2)
                  | E_FMr (reg1, reg2) when reg1 = reg2 ->
                      rdui is
                  | E_Mr (reg1, reg2) when List.length is > 0 ->
                      let next = List.hd is in
                      (* 次の命令がba or balでしかもmrしたものを使う *)
                      if next = E_Ba(reg1) then
                        (E_Ba(reg2)) :: (rdui (List.tl is))
                      else if next = E_Bal(reg1) then
                        (E_Bal(reg2)) :: (rdui (List.tl is))
                      else
                        (E_Mr (reg1, reg2)) :: (rdui is)
                  | E_Sub (reg1, reg2, reg3) when reg2 = reg3 ->
                      (E_FMr(reg1, "r0")) :: (rdui is)
                  | E_Addi (reg1, reg2, Int(i))
                  | E_Slwi (reg1, reg2, i)
                  | E_Srwi (reg1, reg2, i) when i = 0 ->
                      if reg1 = reg2 then
                        rdui is
                      else
                        (E_Mr (reg1, reg2)) :: (rdui is)
                  | E_FSub (reg1, reg2, reg3) when reg2 = reg3 ->
                      (E_FMr(reg1, "fr0")) :: (rdui is)
(*                  | E_FDiv (reg1, reg2, reg3) when reg2 = reg3 *)
                  | E_MfLr(reg) when (is_mtlr reg is search_len) ->
                      let new_is = remove_mtlr reg is search_len in
                        rdui new_is
                  | E_Li (reg1, _)
                  | E_Mr (reg1, _)
                  | E_Addi (reg1, _, _)
                  | E_Add (reg1, _, _)
                  | E_Sub (reg1, _, _)
                  | E_Slwi (reg1, _, _)
                  | E_Srwi (reg1, _, _)
                  | E_Slw (reg1, _, _)
                  | E_Srw (reg1, _, _)
                  | E_FAdd (reg1, _, _)
                  | E_FSub (reg1, _, _)
                  | E_FMul (reg1, _, _)
                  | E_FDiv (reg1, _, _)
                  | E_FMr (reg1, _)
                  | E_Ld (reg1, _, _)
                  | E_FLd (reg1, _, _) when not (is_reg_modified reg1 is search_len)
                      -> rdui is
                  | e -> e :: (rdui is)

let rec f_loop loop codes =
  if loop > 0 then
    let new_codes = rdui codes in
      f_loop (loop - 1) new_codes
  else
    codes

let f codes = f_loop loop codes
