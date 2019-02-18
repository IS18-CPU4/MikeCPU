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

val print_code : out_channel -> t list -> unit
val f : t list -> t list
