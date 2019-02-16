(* open Asm *)

exception ASM_ERR of string

external get32 : float -> int32 = "get32"

type t = (* 命令セット *)
  | Li of reg * simm_or_label
  | Mr of reg * reg
  | Addi of reg * reg * simm_or_label
  | Add of reg * reg * reg
  | Sub of reg * reg * reg
  | Slwi of reg * reg * int
  | Srwi of reg * reg * int
  | Slw of reg * reg * reg
  | Srw of reg * reg * reg
  | FAdd of reg * reg * reg
  | FSub of reg * reg * reg
  | FMul of reg * reg * reg
  | FDiv of reg * reg * reg
  | FMr of reg * reg
  | B of string
  | BEq of string
  | BNE of string
  | BLT of string
  | BL of string
  | BLr
  | Ba of reg
  | Bal of reg
  | MfLr of reg
  | MtLr of reg
  | Cmpwi of reg * reg * int (* creg * reg * simm *)
  | Cmpw of reg * reg * reg (* creg * reg * reg *)
  | FCmp of reg * reg * reg (* creg * freg * freg *)
  | Ld of reg * reg * int
  | St of reg * reg * int
  | FLd of reg * reg * int
  | FSt of reg * reg * int
  | Label of string
  | Comment of string
(*
  | Li of reg * int * t
  | Li of reg * label * t
  | Mr of reg * reg * t
  | Addi of reg * reg * int * t
  | Add of reg * reg * reg * t
  | Sub of reg * reg * reg * t
  | Slwi of reg * reg * int * t
  | Srwi of reg * reg * int * t
  | Slw of reg * reg * reg * t
  | Srw of reg * reg * reg * t
  | FAdd of reg * reg * reg * t
  | FSub of reg * reg * reg * t
  | FMul of reg * reg * reg * t
  | FDiv of reg * reg * reg * t
  | FMr of reg * reg * t
  | B of str * t
  | BEq of str * t
  | BNE of str * t
  | BLT of str * t
  | BL of str * t
  | BLr of t
  | Ba of reg * t
  | Bal of reg * t
  | MfLr of reg * t
  | MtLr of reg * t
  | Cmpwi of reg * reg * int * t (* creg * reg * simm *)
  | Cmpw of reg * reg * reg * t (* creg * reg * reg *)
  | FCmp of reg * reg * reg * t (* creg * freg * freg *)
  | Ld of reg * reg * int * t
  | St of reg * reg * int * t
  | FLd of reg * reg * int * t
  | FSt of reg * reg * int * t
  | END (* コードの最後 *)
*)
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

let regs = Asm.regs
let fregs = Asm.fregs
let reg_sw = Asm.reg_sw
let reg_fsw = Asm.reg_fsw
let reg_hp = Asm.reg_hp
let reg_cl = Asm.reg_cl
let reg_sp = Asm.reg_sp
let reg_tmp = Asm.reg_tmp

let rec print_each_code oc code =
  match code with
  | Li(reg, i_or_l) -> Printf.fprintf oc "\tli\t%s, %s\n" reg (label_to_str i_or_l)
  | Mr (reg1, reg2) -> Printf.fprintf oc "\tmr\t%s, %s\n" reg1 reg2
  | Addi (reg1, reg2, i_or_l) -> Printf.fprintf oc "\taddi\t%s, %s, %s\n" reg1 reg2 (label_to_str i_or_l)
  | Add (reg1, reg2, reg3) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" reg1 reg2 reg3
  | Sub (reg1, reg2, reg3) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" reg1 reg2 reg3
  | Slwi (reg1, reg2, i) -> Printf.fprintf oc "\tslwi\t%s, %s, %d\n" reg1 reg2 i
  | Srwi (reg1, reg2, i) -> Printf.fprintf oc "\tsrwi\t%s, %s, %d\n" reg1 reg2 i
  | Slw (reg1, reg2, reg3) -> Printf.fprintf oc "\tslw\t%s, %s, %s\n" reg1 reg2 reg3
  | Srw (reg1, reg2, reg3) -> Printf.fprintf oc "\tsrw\t%s, %s, %s\n" reg1 reg2 reg3
  | FAdd (reg1, reg2, reg3) -> Printf.fprintf oc "\tfadd\t%s, %s, %s\n" reg1 reg2 reg3
  | FSub (reg1, reg2, reg3) -> Printf.fprintf oc "\tfsub\t%s, %s, %s\n" reg1 reg2 reg3
  | FMul (reg1, reg2, reg3) -> Printf.fprintf oc "\tfmul\t%s, %s, %s\n" reg1 reg2 reg3
  | FDiv (reg1, reg2, reg3) -> Printf.fprintf oc "\tfdiv\t%s, %s, %s\n" reg1 reg2 reg3
  | FMr (reg1, reg2) -> Printf.fprintf oc "\tfmr\t%s, %s\n" reg1 reg2
  | B (str) -> Printf.fprintf oc "\tb\t%s\n" str
  | BEq (str) -> Printf.fprintf oc "\tbeq\t%s\n" str
  | BNE (str) -> Printf.fprintf oc "\tbne\t%s\n" str
  | BLT (str) -> Printf.fprintf oc "\tblt\t%s\n" str
  | BL (str) -> Printf.fprintf oc "\tbl\t%s\n" str
  | BLr -> Printf.fprintf oc "\tblr\n"
  | Ba (reg) -> Printf.fprintf oc "\tba\t%s\n" reg
  | Bal (reg) -> Printf.fprintf oc "\tbal\t%s\n" reg
  | MfLr (reg) -> Printf.fprintf oc "\tmflr\t%s\n" reg
  | MtLr (reg) -> Printf.fprintf oc "\tmtlr\t%s\n" reg
  | Cmpwi (reg1, reg2, i) -> Printf.fprintf oc "\tcmpwi\t%s, %s, %d\n" reg1 reg2 i (* creg * reg * simm *)
  | Cmpw (reg1, reg2, reg3) -> Printf.fprintf oc "\tcmpw\t%s, %s, %s\n" reg1 reg2 reg3 (* creg * reg * reg *)
  | FCmp (reg1, reg2, reg3) -> Printf.fprintf oc "\tfcmp\t%s, %s, %s\n" reg1 reg2 reg3 (* creg * freg * freg *)
  | Ld (reg1, reg2, i) -> Printf.fprintf oc "\tld\t%s, %s, %d\n" reg1 reg2 i
  | St (reg1, reg2, i) -> Printf.fprintf oc "\tst\t%s, %s, %d\n" reg1 reg2 i
  | FLd (reg1, reg2, i) -> Printf.fprintf oc "\tfld\t%s, %s, %d\n" reg1 reg2 i
  | FSt (reg1, reg2, i) -> Printf.fprintf oc "\tfst\t%s, %s, %d\n" reg1 reg2 i
  | Label (str) -> Printf.fprintf oc "%s:\n" str
  | Comment (str) -> Printf.fprintf oc "# %s\n" str
and label_to_str = function
  | Int(i) -> Printf.sprintf "%d" i
  | Ha16(label) -> Printf.sprintf "ha16(%s)" label
  | Lo16(label) -> Printf.sprintf "lo16(%s)" label

let print_code oc codes =
  List.iter (print_each_code oc) codes

let floatlabelmap = ref [] (* ref of label * float list *)
let floatpointmap = ref [] (* ref of float * address(Int) list *)

let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)
let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let savef x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    (let pad =
      if List.length !stackmap mod 2 = 0 then [] else [Id.gentmp Type.Int] in
    stackmap := !stackmap @ pad @ [x; x])
let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | y :: zs -> List.map succ (loc zs) in
  loc !stackmap
let offset x = 4 * List.hd (locate x)
let stacksize () = Asm.align ((List.length !stackmap + 1) * 4)

let lib_bool = ref true

let reg r =
  if Asm.is_reg r
  then String.sub r 1 (String.length r - 1)
  else r

let rec write_library oc ic =
  try
    let s = input_line ic in
      output_string oc (s^"\n");
    write_library oc ic
  with
    e -> output_string oc "#End Library\n"

let rec make_float_data hs flabelmap = (* floatlabelmapからfloatをメモリに入れ続ける, hs = heapsize = それまでのfloatの数 ただし hs * 4 < 32768 であって欲しい(即値の限界)*)
  match flabelmap with
    | [] -> []
    | (_, data)::labels -> floatpointmap := (data, hs)::!floatpointmap;
                           let i = Int32.to_int (get32 data) in
                           let n = i lsr 16 in
                           let m = i lxor (n lsl 16) in
                           let m_top = m lsr 15 in
                             [Li(reg reg_tmp, Int((n+m_top) mod 65536));
                             Slwi(reg reg_tmp, reg reg_tmp, 16);
                             Addi(reg reg_tmp, reg reg_tmp, Int(m));
                             St(reg reg_tmp, reg reg_hp, hs)] @ (make_float_data (hs - 4) labels)
(*
                           (Printf.sprintf "\tli\t%s, %d\n" (reg reg_tmp) ((n+m_top) mod 65536))
                           ^ (Printf.sprintf "\tslwi\t%s, %s, 16\n" (reg reg_tmp) (reg reg_tmp))
                           ^ (Printf.sprintf "\taddi\t%s, %s, %d\n" (reg reg_tmp) (reg reg_tmp) m)
                           ^ (Printf.sprintf "\tst\t%s, %s, %d\n" (reg reg_tmp) (reg reg_hp) hs)
                           ^ (make_float_data (hs - 4) labels)
*)

let load_label r label =
(*
  let r' = reg r in
  let int_label = int_of_string label in (* labelが10進前提 -> 嘘、L(関数名) の関数名がlabel、、、その命令アドレスは取得できない *)
  let ha_label = int_label lsr 16 in
  let lo_label = int_label - (ha_label lsl 16) in
  Printf.sprintf
(*    "\tli\t%s, %d\n\tslwi\t%s, %s, %d\n\taddi\t%s, %s, %d\n" *)
    "\tli\t%s, %d\n\taddi\t%s, %s, %d\n"
    r' ha_label r' r' lo_label
*)
  let r' = reg r in
    [Li(r', Lo16(label));
    Slwi(r', r', 16);
    Srwi(r', r', 31);
    Addi(r', r', Ha16(label));
    Slwi(r', r', 16);
    Addi(r', r', Lo16(label))]

(*
  Printf.sprintf
    "\tli\t%s, lo16(%s)\n\
     \tslwi\t%s, %s, 16\n\
     \tsrwi\t%s, %s, 31\n\
     \taddi\t%s, %s, ha16(%s)\n\
     \tslwi\t%s, %s, 16\n\
     \taddi\t%s, %s, lo16(%s)\n"
    r' label
    r' r'
    r' r'
    r' r' label
    r' r'
    r' r' label
*)

(* 関数呼び出しのために引数を並べ替える(register shuffling) (caml2html: emit_shuffle) *)
let rec shuffle sw xys =
  (* remove identical moves *)
  let _, xys = List.partition (fun (x, y) -> x = y) xys in
  (* find acyclic moves *)
  match List.partition (fun (_, y) -> List.mem_assoc y xys) xys with
  | [], [] -> []
  | (x, y) :: xys, [] -> (* no acyclic moves; resolve a cyclic move *)
      (y, sw) :: (x, y) :: shuffle sw (List.map
                                         (function
                                           | (y', z) when y = y' -> (sw, z)
                                           | yz -> yz)
                                         xys)
  | xys, acyc -> acyc @ shuffle sw xys

type dest = Tail | NonTail of Id.t (* 末尾かどうかを表すデータ型 (caml2html: emit_dest) *)
let rec g = function (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  | dest, Asm.Ans(exp) -> g' (dest, exp)
  | dest, Asm.Let((x, t), exp, e) ->
      (g' (NonTail(x), exp)) @ (g (dest, e))
and g' = function (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  | NonTail(_), Asm.Nop -> []
  | NonTail(x), Asm.Li(i) when -32768 <= i && i < 32768 -> [Li(reg x, Int(i))] (* Printf.fprintf oc "\tli\t%s, %d\n" (reg x) i *)
  | NonTail(x), Asm.Li(i) ->
      let n = i lsr 16 in
      let m = i lxor (n lsl 16) in
      let m_top = m lsr 15 in
      let r = reg x in
        [Li(r, Int((n+m_top) mod 65536));
        Slwi(r, r, 16);
        Addi(r, r, Int(m))]
(*
      Printf.fprintf oc "\tli\t%s, %d\n" r ((n+m_top) mod 65536);
      Printf.fprintf oc "\tslwi\t%s, %s, 16\n" r r;
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" r r m
*)
(*
  | NonTail(x), FLi(Id.L(l)) ->
      let ss = stacksize () in
      let labeled_float = List.assoc (Id.L(l)) !floatmap in
      let i = Int32.to_int (get32 labeled_float) in
      let n = i lsr 16 in
      let m = i lxor (n lsl 16) in
      let m_top = m lsr 15 in
      let r = reg x in
      Printf.fprintf oc "\tli\t%s, %d\n" (reg reg_tmp) ((n+m_top) mod 65536);
      Printf.fprintf oc "\tslwi\t%s, %s, 16\n" (reg reg_tmp) (reg reg_tmp);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_tmp) (reg reg_tmp) m;
      Printf.fprintf oc "\tst\t%s, %s, %d\n" (reg reg_tmp) (reg reg_sp) (ss);
      Printf.fprintf oc "\tfld\t%s, %s, %d\n" (reg x) (reg reg_sp) (ss)
*)
  | NonTail(x), Asm.FLi(Id.L(l)) ->
      let labeled_float = List.assoc (Id.L(l)) !floatlabelmap in (* ラベルに関連付けられたfloatの値 *)
      let float_point = List.assoc (labeled_float) !floatpointmap in (* floatの値がある絶対アドレス *)
      if float_point < 32768 then
        (* Printf.fprintf oc "\tfld\t%s, %s, %d\n" (reg x) "r0" (float_point) *)
        [FLd(reg x, "r0", float_point)]
      else
        let n = float_point lsr 16 in
        let m = float_point lxor (n lsl 16) in
        let m_top = m lsr 15 in
        let r = reg x in
          [Li(reg reg_tmp, Int((n+m_top) mod 65536));
          Slwi(reg reg_tmp, reg reg_tmp, 16);
          FLd(reg x, reg reg_tmp, m)]
(*
        Printf.fprintf oc "\tli\t%s, %d\n" (reg reg_tmp) ((n+m_top) mod 65536);
        Printf.fprintf oc "\tslwi\t%s, %s, 16\n" (reg reg_tmp) (reg reg_tmp);
        Printf.fprintf oc "\tfld\t%s, %s, %d\n" (reg x) (reg reg_tmp) m
*)
  | NonTail(x), Asm.SetL(Id.L(y)) ->
      let s = load_label x y in
        s
(*      Printf.fprintf oc "%s" s *)
  | NonTail(x), Asm.Mr(y) when x = y -> []
  | NonTail(x), Asm.Mr(y) -> (* Printf.fprintf oc "\tmr\t%s, %s\n" (reg x) (reg y) *)
                             [Mr(reg x, reg y)]
(*
  | NonTail(x), Neg(y) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg x) (reg "%r0") (reg y)
  | NonTail(x), Add(y, Asm.V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), Add(y, Asm.C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg x) (reg y) z
  | NonTail(x), Sub(y, Asm.V(z)) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), Sub(y, Asm.C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg x) (reg y) (-z)
  | NonTail(x), Slw(y, Asm.V(z)) -> Printf.fprintf oc "\tslw\t%s, %s, %s\n" (reg x) (reg y) (reg z) (* 要用意 *)
  | NonTail(x), Slw(y, Asm.C(z)) -> Printf.fprintf oc "\tslwi\t%s, %s, %d\n" (reg x) (reg y) z
  | NonTail(x), Srw(y, Asm.V(z)) -> Printf.fprintf oc "\tsrw\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), Srw(y, Asm.C(z)) -> Printf.fprintf oc "\tsrwi\t%s, %s, %d\n" (reg x) (reg y) z
  | NonTail(x), Lwz(y, Asm.V(z))-> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg reg_tmp) (reg y) (reg z);
                               Printf.fprintf oc "\tld\t%s, %s, 0\n" (reg x) (reg reg_tmp)
  | NonTail(x), Lwz(y, Asm.C(z)) -> Printf.fprintf oc "\tld\t%s, %s, %d\n" (reg x) (reg y) z
  | NonTail(_), Stw(x, y, Asm.V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg reg_tmp) (reg y) (reg z);
                                   Printf.fprintf oc "\tst\t%s, %s, 0\n" (reg x) (reg reg_tmp)
  | NonTail(_), Stw(x, y, Asm.C(z)) -> Printf.fprintf oc "\tst\t%s, %s, %d\n" (reg x) (reg y) z
  | NonTail(x), FMr(y) when x = y -> ()
  | NonTail(x), FMr(y) -> Printf.fprintf oc "\tfmr\t%s, %s\n" (reg x) (reg y)
  | NonTail(x), FNeg(y) -> Printf.fprintf oc "\tfsub\t%s, %s, %s\n" (reg x) (reg "%fr0") (reg y)
  | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\tfadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\tfsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\tfmul\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), FDiv(y, z) -> Printf.fprintf oc "\tfdiv\t%s, %s, %s\n" (reg x) (reg y) (reg z)
(*
  | NonTail(x), Lfd(y, Asm.V(z)) -> Printf.fprintf oc "\tlfdx\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), Lfd(y, Asm.C(z)) -> Printf.fprintf oc "\tlfd\t%s, %d(%s)\n" (reg x) z (reg y)
  | NonTail(_), Stfd(x, y, Asm.V(z)) -> Printf.fprintf oc "\tstfdx\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(_), Stfd(x, y, Asm.C(z)) -> Printf.fprintf oc "\tstfd\t%s, %d(%s)\n" (reg x) z (reg y)
*)
  | NonTail(x), Lfd(y, Asm.V(z))-> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg y) (reg y) (reg z);
                               Printf.fprintf oc "\tfld\t%s, %s, 0\n" (reg x) (reg y);
                               Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg y) (reg y) (reg z)
  | NonTail(x), Lfd(y, Asm.C(z)) -> Printf.fprintf oc "\tfld\t%s, %s, %d\n" (reg x) (reg y) z
  | NonTail(_), Stfd(x, y, Asm.V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg y) (reg y) (reg z);
                                    Printf.fprintf oc "\tfst\t%s, %s, 0\n" (reg x) (reg y);
                                    Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg y) (reg y) (reg z)
  | NonTail(_), Stfd(x, y, Asm.C(z)) -> Printf.fprintf oc "\tfst\t%s, %s, %d\n" (reg x) (reg y) z

  | NonTail(_), Asm.Comment(s) -> Printf.fprintf oc "#\t%s\n" s
*)
  | NonTail(x), Asm.Neg(y) -> [Sub (reg x, reg "%r0", reg y)]
  | NonTail(x), Asm.Add(y, Asm.V(z)) -> [Add (reg x, reg y, reg z)]
  | NonTail(x), Asm.Add(y, Asm.C(z)) -> [Addi(reg x, reg y, Int(z))]
  | NonTail(x), Asm.Sub(y, Asm.V(z)) -> [Sub(reg x, reg y,reg z)]
  | NonTail(x), Asm.Sub(y, Asm.C(z)) -> [Addi(reg x, reg y, Int(-z))]
  | NonTail(x), Asm.Slw(y, Asm.V(z)) -> [Slw(reg x, reg y, reg z)] (* 要用意 *)
  | NonTail(x), Asm.Slw(y, Asm.C(z)) -> [Slwi(reg x, reg y, z)]
  | NonTail(x), Asm.Srw(y, Asm.V(z)) -> [Srw(reg x, reg y, reg z)]
  | NonTail(x), Asm.Srw(y, Asm.C(z)) -> [Srwi(reg x, reg y, z)]
  | NonTail(x), Asm.Lwz(y, Asm.V(z))-> [Add(reg reg_tmp, reg y, reg z);
                                    Ld(reg x, reg reg_tmp, 0)]
  | NonTail(x), Asm.Lwz(y, Asm.C(z)) -> [Ld(reg x, reg y, z)]
  | NonTail(_), Asm.Stw(x, y, Asm.V(z)) -> [Add(reg reg_tmp, reg y, reg z);
                                        St(reg x, reg reg_tmp, 0)]
  | NonTail(_), Asm.Stw(x, y, Asm.C(z)) -> [St(reg x, reg y, z)]
  | NonTail(x), Asm.FMr(y) when x = y -> []
  | NonTail(x), Asm.FMr(y) -> [FMr(reg x, reg y)]
  | NonTail(x), Asm.FNeg(y) -> [FSub(reg x, reg "%fr0", reg y)]
  | NonTail(x), Asm.FAdd(y, z) -> [FAdd(reg x, reg y, reg z)]
  | NonTail(x), Asm.FSub(y, z) -> [FSub(reg x, reg y, reg z)]
  | NonTail(x), Asm.FMul(y, z) -> [FMul(reg x, reg y, reg z)]
  | NonTail(x), Asm.FDiv(y, z) -> [FDiv(reg x, reg y, reg z)]
(*
  | NonTail(x), Lfd(y, Asm.V(z)) -> Printf.fprintf oc "\tlfdx\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), Lfd(y, Asm.C(z)) -> Printf.fprintf oc "\tlfd\t%s, %d(%s)\n" (reg x) z (reg y)
  | NonTail(_), Stfd(x, y, Asm.V(z)) -> Printf.fprintf oc "\tstfdx\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(_), Stfd(x, y, Asm.C(z)) -> Printf.fprintf oc "\tstfd\t%s, %d(%s)\n" (reg x) z (reg y)
*)
  | NonTail(x), Asm.Lfd(y, Asm.V(z))-> [Add(reg reg_tmp, reg y, reg z);
                                    FLd(reg x, reg reg_tmp, 0)]
  | NonTail(x), Asm.Lfd(y, Asm.C(z)) -> [FLd(reg x, reg y, z)]
  | NonTail(_), Asm.Stfd(x, y, Asm.V(z)) -> [Add(reg reg_tmp, reg y, reg z);
                                         FSt (reg x, reg reg_tmp, 0)]
  | NonTail(_), Asm.Stfd(x, y, Asm.C(z)) -> [FSt(reg x, reg y, z)]
  | NonTail(_), Asm.Comment(s) -> [Comment(s)]
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
(*
  | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
      Printf.fprintf oc "\tst\t%s, %s, %d\n" (reg x) (reg reg_sp) (offset y)
  | NonTail(_), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
      save y;
      Printf.fprintf oc "\tfst\t%s, %s, %d\n" (reg x) (reg reg_sp) (offset y)
*)
  | NonTail(_), Asm.Save(x, y) when List.mem x Asm.allregs && not (S.mem y !stackset) ->
      save y;
      [St(reg x, reg reg_sp, offset y)]
  | NonTail(_), Asm.Save(x, y) when List.mem x Asm.allfregs && not (S.mem y !stackset) ->
      save y;
      [FSt(reg x, reg reg_sp, offset y)]
  | NonTail(_), Asm.Save(x, y) -> assert (S.mem y !stackset); []
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
(*
  | NonTail(x), Restore(y) when List.mem x allregs ->
      Printf.fprintf oc "\tld\t%s, %s, %d\n" (reg x) (reg reg_sp) (offset y)
  | NonTail(x), Restore(y) ->
      assert (List.mem x allfregs);
      Printf.fprintf oc "\tfld\t%s, %s, %d\n" (reg x) (reg reg_sp) (offset y)
*)
  | NonTail(x), Asm.Restore(y) when List.mem x Asm.allregs ->
      [Ld(reg x, reg reg_sp, offset y)]
  | NonTail(x), Asm.Restore(y) ->
      assert (List.mem x Asm.allfregs);
      [FLd(reg x, reg reg_sp, offset y)]

  (* 末尾だったら計算結果を第一レジスタにセットしてリターン (caml2html: emit_tailret) *)
(*
  | Tail, (Nop | Stw _ | Stfd _ | Asm.Comment _ | Save _ as exp) ->
      g' oc (NonTail(Id.gentmp Type.Unit), exp);
      Printf.fprintf oc "\tblr\n";
  | Tail, (Li _ | SetL _ | Mr _ | Neg _ | Add _ | Sub _ | Slw _ | Srw _ | Lwz _ as exp) ->
      g' oc (NonTail(regs.(0)), exp);
      Printf.fprintf oc "\tblr\n";
  | Tail, (FLi _ | FMr _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | Lfd _ as exp) ->
      g' oc (NonTail(fregs.(0)), exp);
      Printf.fprintf oc "\tblr\n";
  | Tail, (Restore(x) as exp) ->
      (match locate x with
      | [i] -> g' oc (NonTail(regs.(0)), exp)
      | [i; j] when i + 1 = j -> g' oc (NonTail(fregs.(0)), exp)
      | _ -> assert false);
      Printf.fprintf oc "\tblr\n";
  | Tail, IfEq(x, Asm.V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr0, %s, %s\n" (reg x) (reg y);
      g'_tail_if oc e1 e2 "beq" "bne"
  | Tail, IfEq(x, Asm.C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr0, %s, %d\n" (reg x) y;
      g'_tail_if oc e1 e2 "beq" "bne"
  | Tail, IfLE(x, Asm.V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr0, %s, %s\n" (reg x) (reg y);
      g'_tail_if_le oc e1 e2 (* "ble" "bgt" *)
  | Tail, IfLE(x, Asm.C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr0, %s, %d\n" (reg x) y;
      g'_tail_if_le oc e1 e2 (* "ble" "bgt" *)
  | Tail, IfGE(x, Asm.V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr0, %s, %s\n" (reg x) (reg y);
      g'_tail_if oc e1 e2 "bge" "blt"
  | Tail, IfGE(x, Asm.C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr0, %s, %d\n" (reg x) y;
      g'_tail_if oc e1 e2 "bge" "blt"
  | Tail, IfFEq(x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmp\tcr0, %s, %s\n" (reg x) (reg y);
      g'_tail_if oc e1 e2 "beq" "bne"
  | Tail, IfFLE(x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmp\tcr0, %s, %s\n" (reg x) (reg y);
      g'_tail_if_le oc e1 e2 (* "ble" "bgt" *)
  | NonTail(z), IfEq(x, Asm.V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr0, %s, %s\n" (reg x) (reg y);
      g'_non_tail_if oc (NonTail(z)) e1 e2 "beq" "bne"
  | NonTail(z), IfEq(x, Asm.C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr0, %s, %d\n" (reg x) y;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "beq" "bne"
  | NonTail(z), IfLE(x, Asm.V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr0, %s, %s\n" (reg x) (reg y);
      g'_non_tail_if_le oc (NonTail(z)) e1 e2 (*"ble" "bgt" *)
  | NonTail(z), IfLE(x, Asm.C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr0, %s, %d\n" (reg x) y;
      g'_non_tail_if_le oc (NonTail(z)) e1 e2 (* "ble" "bgt" *)
  | NonTail(z), IfGE(x, Asm.V(y), e1, e2) ->
      Printf.fprintf oc "\tcmpw\tcr0, %s, %s\n" (reg x) (reg y);
      g'_non_tail_if oc (NonTail(z)) e1 e2 "bge" "blt"
  | NonTail(z), IfGE(x, Asm.C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr0, %s, %d\n" (reg x) y;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "bge" "blt"
  | NonTail(z), IfFEq(x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmp\tcr0, %s, %s\n" (reg x) (reg y);
      g'_non_tail_if oc (NonTail(z)) e1 e2 "beq" "bne"
  | NonTail(z), IfFLE(x, y, e1, e2) ->
      Printf.fprintf oc "\tfcmp\tcr0, %s, %s\n" (reg x) (reg y);
      g'_non_tail_if_le oc (NonTail(z)) e1 e2 (* "ble" "bgt" *)
*)
  | Tail, (Asm.Nop | Asm.Stw _ | Asm.Stfd _ | Asm.Comment _ | Asm.Save _ as exp) ->
      (g' (NonTail(Id.gentmp Type.Unit), exp)) @ [BLr]
  | Tail, (Asm.Li _ | Asm.SetL _ | Asm.Mr _ | Asm.Neg _ | Asm.Add _ | Asm.Sub _ | Asm.Slw _ | Asm.Srw _ | Asm.Lwz _ as exp) ->
      (g' (NonTail(regs.(0)), exp)) @ [BLr]
  | Tail, (Asm.FLi _ | Asm.FMr _ | Asm.FNeg _ | Asm.FAdd _ | Asm.FSub _ | Asm.FMul _ | Asm.FDiv _ | Asm.Lfd _ as exp) ->
      (g' (NonTail(fregs.(0)), exp)) @ [BLr]
  | Tail, (Asm.Restore(x) as exp) ->
      (match locate x with
      | [i] -> g' (NonTail(regs.(0)), exp)
      | [i; j] when i + 1 = j -> g' (NonTail(fregs.(0)), exp)
      | _ -> assert false) @ [BLr]
  | Tail, Asm.IfEq(x, Asm.V(y), e1, e2) ->
      [Cmpw("cr0", reg x, reg y)] @
      (g'_tail_if e1 e2 "beq" "bne")
  | Tail, Asm.IfEq(x, Asm.C(y), e1, e2) ->
      [Cmpwi("cr0", reg x, y)] @
      (g'_tail_if e1 e2 "beq" "bne")
  | Tail, Asm.IfLE(x, Asm.V(y), e1, e2) ->
      [Cmpw("cr0", reg x, reg y)] @
      (g'_tail_if_le e1 e2) (* "ble" "bgt" *)
  | Tail, Asm.IfLE(x, Asm.C(y), e1, e2) ->
      [Cmpwi ("cr0", reg x, y)] @
      (g'_tail_if_le e1 e2 )(* "ble" "bgt" *)
  | Tail, Asm.IfGE(x, Asm.V(y), e1, e2) ->
      [Cmpw("cr0", reg x, reg y)] @
      (g'_tail_if e1 e2 "bge" "blt")
  | Tail, Asm.IfGE(x, Asm.C(y), e1, e2) ->
      [Cmpwi ("cr0", reg x, y)] @
      (g'_tail_if e1 e2 "bge" "blt")
  | Tail, Asm.IfFEq(x, y, e1, e2) ->
      [FCmp("cr0", reg x, reg y)] @
      (g'_tail_if e1 e2 "beq" "bne")
  | Tail, Asm.IfFLE(x, y, e1, e2) ->
      [FCmp("cr0", reg x, reg y)] @
      (g'_tail_if_le e1 e2) (* "ble" "bgt" *)
  | NonTail(z), Asm.IfEq(x, Asm.V(y), e1, e2) ->
      [Cmpw("cr0", reg x, reg y)] @
      (g'_non_tail_if (NonTail(z)) e1 e2 "beq" "bne")
  | NonTail(z), Asm.IfEq(x, Asm.C(y), e1, e2) ->
      [Cmpwi ("cr0", reg x, y)] @
      (g'_non_tail_if (NonTail(z)) e1 e2 "beq" "bne")
  | NonTail(z), Asm.IfLE(x, Asm.V(y), e1, e2) ->
      [Cmpw("cr0", reg x, reg y)] @
      (g'_non_tail_if_le (NonTail(z)) e1 e2) (*"ble" "bgt" *)
  | NonTail(z), Asm.IfLE(x, Asm.C(y), e1, e2) ->
      [Cmpwi ("cr0", reg x, y)] @
      (g'_non_tail_if_le (NonTail(z)) e1 e2) (* "ble" "bgt" *)
  | NonTail(z), Asm.IfGE(x, Asm.V(y), e1, e2) ->
      [Cmpw("cr0", reg x, reg y)] @
      (g'_non_tail_if (NonTail(z)) e1 e2 "bge" "blt")
  | NonTail(z), Asm.IfGE(x, Asm.C(y), e1, e2) ->
      [Cmpwi ("cr0", reg x, y)] @
      (g'_non_tail_if (NonTail(z)) e1 e2 "bge" "blt")
  | NonTail(z), Asm.IfFEq(x, y, e1, e2) ->
      [FCmp("cr0", reg x, reg y)] @
      (g'_non_tail_if (NonTail(z)) e1 e2 "beq" "bne")
  | NonTail(z), Asm.IfFLE(x, y, e1, e2) ->
      [FCmp("cr0", reg x, reg y)] @
      (g'_non_tail_if_le (NonTail(z)) e1 e2) (* "ble" "bgt" *)

  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
(*
  | Tail, Asm.CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys zs;
      Printf.fprintf oc "\tld\t%s, %s, 0\n" (reg reg_sw) (reg reg_cl);
      Printf.fprintf oc "\tmr\tr29, %s\n\tba r29\n" (reg reg_sw);
  | Tail, Asm.CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      g'_args oc [] ys zs;
      Printf.fprintf oc "\tb\t%s\n" x
  | NonTail(a), Asm.CallCls(x, ys, zs) ->
      Printf.fprintf oc "\tmflr\t%s\n" (reg reg_tmp);
      g'_args oc [(x, reg_cl)] ys zs;
      let ss = stacksize () in
      Printf.fprintf oc "\tst\t%s, %s, %d\n" (reg reg_tmp) (reg reg_sp) (ss - 4);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tld\t%s, %s, 0\n" (reg reg_tmp) (reg reg_cl);
      Printf.fprintf oc "\tmr\tr29, %s\n" (reg reg_tmp);
      Printf.fprintf oc "\tbal\tr29\n";
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) (-ss);
      Printf.fprintf oc "\tld\t%s, %s, %d\n" (reg reg_tmp) (reg reg_sp) (ss - 4);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tmr\t%s, %s\n" (reg a) (reg regs.(0))
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfmr\t%s, %s\n" (reg a) (reg fregs.(0));
      Printf.fprintf oc "\tmtlr\t%s\n" (reg reg_tmp)
  | (NonTail(a), Asm.CallDir(Id.L(x), ys, zs)) ->
      Printf.fprintf oc "\tmflr\t%s\n" (reg reg_tmp);
      g'_args oc [] ys zs;
      let ss = stacksize () in
      Printf.fprintf oc "\tst\t%s, %s, %d\n" (reg reg_tmp) (reg reg_sp) (ss - 4);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tbl\t%s\n" x;
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) (-ss);
      Printf.fprintf oc "\tld\t%s, %s, %d\n" (reg reg_tmp) (reg reg_sp) (ss - 4);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tmr\t%s, %s\n" (reg a) (reg regs.(0))
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfmr\t%s, %s\n" (reg a) (reg fregs.(0));
      Printf.fprintf oc "\tmtlr\t%s\n" (reg reg_tmp)
*)
  | Tail, Asm.CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      (g'_args [(x, reg_cl)] ys zs) @
      [Ld(reg reg_sw, reg reg_cl, 0);
       Mr("r29", reg reg_sw);
       Ba("r29")]
  | Tail, Asm.CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      (g'_args [] ys zs) @
      [B("x")]
  | NonTail(a), Asm.CallCls(x, ys, zs) ->
      let ss = stacksize () in
      [MfLr(reg reg_tmp)] @
      (g'_args [(x, reg_cl)] ys zs) @
      [St(reg reg_tmp, reg reg_sp, ss - 4);
       Addi(reg reg_sp, reg reg_sp, Int(ss));
       Ld(reg reg_tmp, reg reg_cl, 0);
       Mr("r29", reg reg_tmp);
       Bal("r29");
       Addi(reg reg_sp, reg reg_sp, Int(-ss));
       Ld(reg reg_tmp, reg reg_sp, ss - 4);
       (if List.mem a Asm.allregs && a <> regs.(0) then
         Mr(reg a, reg regs.(0))
       else if List.mem a Asm.allfregs && a <> fregs.(0) then
         FMr(reg a, reg fregs.(0))
       else
         raise (ASM_ERR("Dose not use reg"^ reg a)));
       MtLr(reg reg_tmp)]
  | (NonTail(a), Asm.CallDir(Id.L(x), ys, zs)) ->
      let ss = stacksize () in
      [MfLr(reg reg_tmp)] @
      (g'_args [] ys zs) @
      [St(reg reg_tmp, reg reg_sp, ss - 4);
       Addi(reg reg_sp, reg reg_sp, Int(ss));
       BL(x);
       Addi(reg reg_sp, reg reg_sp, Int(-ss));
       Ld(reg reg_tmp, reg reg_sp, ss - 4);
      (if List.mem a Asm.allregs && a <> regs.(0) then
        Mr(reg a, reg regs.(0))
      else if List.mem a Asm.allfregs && a <> fregs.(0) then
        FMr(reg a, reg fregs.(0))
      else
        raise (ASM_ERR("Dose not use reg"^ reg a)));
      MtLr(reg reg_tmp)]
(*
and g'_tail_if oc e1 e2 b bn = (* 本来cr7で今回cr0に変更したけど大丈夫ならそのまま *)
  let b_else = Id.genid (b ^ "_else") in
  Printf.fprintf oc "\t%s\t%s\n" bn b_else;
  let stackset_back = !stackset in
  g oc (Tail, e1);
  Printf.fprintf oc "%s:\n" b_else;
  stackset := stackset_back;
  g oc (Tail, e2)
and g'_non_tail_if oc dest e1 e2 b bn =
  let b_else = Id.genid (b ^ "_else") in
  let b_cont = Id.genid (b ^ "_cont") in
  Printf.fprintf oc "\t%s\t%s\n" bn b_else;
  let stackset_back = !stackset in
  g oc (dest, e1);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tb\t%s\n" b_cont;
  Printf.fprintf oc "%s:\n" b_else;
  stackset := stackset_back;
  g oc (dest, e2);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_tail_if_le oc e1 e2 =
  let b_le = Id.genid ("le") in
  Printf.fprintf oc "\tblt\t%s\n" b_le;
  Printf.fprintf oc "\tbeq\t%s\n" b_le;
  let stackset_back = !stackset in
  g oc (Tail, e2); (* leを満たさない時e2をやる *)
  Printf.fprintf oc "%s:\n" b_le;
  stackset := stackset_back;
  g oc (Tail, e1)
and g'_non_tail_if_le oc dest e1 e2 =
  let b_le = Id.genid ("le") in
  let b_cont = Id.genid ("gt_cont") in
  Printf.fprintf oc "\tblt\t%s\n" b_le;
  Printf.fprintf oc "\tbeq\t%s\n" b_le;
  let stackset_back = !stackset in
  g oc (dest, e2);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tb\t%s\n" b_cont; (*　ジャンプ？ *)
  Printf.fprintf oc "%s:\n" b_le;
  stackset := stackset_back;
  g oc (dest, e1);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_args oc x_reg_cl ys zs =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  List.iter
    (fun (y, r) -> Printf.fprintf oc "\tmr\t%s, %s\n" (reg r) (reg y))
    (shuffle reg_sw yrs);
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  List.iter
    (fun (z, fr) -> Printf.fprintf oc "\tfmr\t%s, %s\n" (reg fr) (reg z))
    (shuffle reg_fsw zfrs)
*)
and str_to_b s label =
  match s with
   | "beq" -> [BEq(label)]
   | "bne" -> [BNE(label)]
   | "blt" -> [BLT(label)]
   | e -> raise (ASM_ERR ("Not use " ^ e))
and g'_tail_if e1 e2 b bn = (* 本来cr7で今回cr0に変更したけど大丈夫ならそのまま *)
  let b_else = Id.genid (b ^ "_else") in
  let code1 = str_to_b bn b_else in
  let stackset_back = !stackset in
  let code2 = (g (Tail, e1)) @ [Label(b_else)] in
  stackset := stackset_back;
  code1 @ code2 @ (g (Tail, e2))
and g'_non_tail_if dest e1 e2 b bn =
  let b_else = Id.genid (b ^ "_else") in
  let b_cont = Id.genid (b ^ "_cont") in
  let code1 = str_to_b bn b_else in
  let stackset_back = !stackset in
  let code2 = g (dest, e1) in
  let stackset1 = !stackset in
  let code3 = [B(b_cont);Label(b_else)] in
  stackset := stackset_back;
  let code4 = g (dest, e2) in
  let code5 = [Label(b_cont)] in
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2;
  code1@code2@code3@code4@code5
and g'_tail_if_le e1 e2 =
  let b_le = Id.genid ("le") in
  let code1 = [BLT(b_le);BEq(b_le)] in
  let stackset_back = !stackset in
  let code2 = g (Tail, e2) in (* leを満たさない時e2をやる *)
  let code3 = [Label(b_le)] in
  stackset := stackset_back;
  code1@code2@code3@(g (Tail, e1))
and g'_non_tail_if_le dest e1 e2 =
  let b_le = Id.genid ("le") in
  let b_cont = Id.genid ("gt_cont") in
  let code1 = [BLT(b_le);BEq(b_le)] in
  let stackset_back = !stackset in
  let code2 = g (dest, e2) in
  let stackset1 = !stackset in
  let code3 = [B(b_cont); Label(b_le)] in (*　ジャンプ？ *)
  stackset := stackset_back;
  let code4 = g (dest, e1) in
  let code5 = [Label(b_cont)] in
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2;
  code1@code2@code3@code4@code5
and g'_args x_reg_cl ys zs =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  let code1 = List.map
                (fun (y, r) -> Mr(reg r, reg y))
                (shuffle reg_sw yrs) in
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  let code2 = List.map
                (fun (z, fr) -> FMr(reg fr, reg z))
                (shuffle reg_fsw zfrs) in
  code1@code2

let h { Asm.name = Id.L(x); Asm.args = _; Asm.fargs = _; Asm.body = e; Asm.ret = _ } =
(*  Printf.fprintf oc "%s:\n" x; *)
  stackset := S.empty;
  stackmap := [];
  Label(x) :: (g (Tail, e))


let f oc (Asm.Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  Printf.fprintf oc "\t.text\n";
  Printf.fprintf oc "\t.globl _min_caml_start\n";
  Printf.fprintf oc "\t.align 2\n";
  (* libmincaml.S埋め込み *)
  if (!lib_bool) then
    (Printf.fprintf oc "#Library\n";
    let inchan = open_in ("libmincaml.S") in
      write_library oc inchan;
    close_in inchan);
  (* floatのアドレス対応生成->floatsのstringにまとめて後でコードに埋め込む *)
  floatlabelmap := data;
  let hs = (List.length !floatlabelmap - 1) * 4 in
  if hs >= 32768 then raise (ASM_ERR "too many float_simm!");
  let floats = make_float_data hs !floatlabelmap in
  (* 関数埋め込み *)
  let fundefcodes = List.concat (List.map (fun fundef -> h fundef) fundefs) in
  print_code oc fundefcodes;
  (* start program *)
  Printf.fprintf oc "_min_caml_start:\n";
  Printf.fprintf oc "\tli\t%s, %d\n" (reg reg_sp) 0x7;
  Printf.fprintf oc "\tslwi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) 16;
  Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) 0x4e0;
  Printf.fprintf oc "\tli\t%s, %d\n" (reg reg_hp) 0;
  (* float data 埋め込み *)
  Printf.fprintf oc "#\tfloat data\n";
  print_code oc floats;
  Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_hp) (reg reg_hp) (Asm.align hs); (* ヒープポインタ更新 *)
  Printf.fprintf oc "#\tend float data\n";
  (* main program *)
  Printf.fprintf oc "#\tmain program starts\n";
  stackset := S.empty;
  stackmap := [];
  let maincode = g (NonTail("_R_0"), e) in
  print_code oc maincode;
  Printf.fprintf oc "#\tmain program ends\n";


(*
let f oc (Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  Printf.fprintf oc "\t.text\n";
  Printf.fprintf oc "\t.globl _min_caml_start\n";
  Printf.fprintf oc "\t.align 2\n";
  (* libmincaml.S埋め込み *)
  if (!lib_bool) then
    (Printf.fprintf oc "#Library\n";
    let inchan = open_in ("libmincaml.S") in
      write_library oc inchan;
    close_in inchan);
  (* floatのアドレス対応生成->floatsのstringにまとめて後でコードに埋め込む *)
  floatlabelmap := data;
  let hs = (List.length !floatlabelmap - 1) * 4 in
  if hs >= 32768 then raise (ASM_ERR "too many float_simm!");
  let floats = make_float_data hs !floatlabelmap in
  (* 関数埋め込み *)
  List.iter (fun fundef -> h oc fundef) fundefs;
(*  Printf.fprintf oc "_min_caml_start: # main entry point\n"; *)
  Printf.fprintf oc "_min_caml_start:\n";
  Printf.fprintf oc "\tli\t%s, %d\n" (reg reg_sp) 0x7;
  Printf.fprintf oc "\tslwi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) 16;
  Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) 0x4e0;
  Printf.fprintf oc "\tli\t%s, %d\n" (reg reg_hp) 0;
(* (* エントリーポイントはいらない *)
  Printf.fprintf oc "_min_caml_start:\n # main entry point\n";
  Printf.fprintf oc "\tmflr\tr0\n";
  (*
  Printf.fprintf oc "\tstmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tstw\tr0, 8(r1)\n";
  Printf.fprintf oc "\tstwu\tr1, -96(r1)\n";
  *)
  Printf.fprintf oc "\tstmw\tr30, r1, -8\n";
  Printf.fprintf oc "\tst\tr0, r1, 8\n";
  Printf.fprintf oc "\tst\tr1, r1, -96\n"; (* stwuなんてstwと同じだよね(フラグ) *)
*)
  (* float data 埋め込み *)
  Printf.fprintf oc "#\tfloat data\n";
  Printf.fprintf oc "%s" floats;
  Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_hp) (reg reg_hp) (align hs); (* ヒープポインタ更新 *)
  Printf.fprintf oc "#\tend float data\n";
  (* main program *)
  Printf.fprintf oc "#\tmain program starts\n";
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail("_R_0"), e);
  Printf.fprintf oc "#\tmain program ends\n";
  (* Printf.fprintf oc "\tmr\tr3, %s\n" regs.(0); (* なんかコメントアウトしてる *)*)
(* 以下終了処理 *)
(*
  (* libmincaml.S埋め込み->ここに埋め込むならまず、先に終了処理何か居る *)
  if (!lib_bool) then
    (Printf.fprintf oc "#Library\n";
    let inchan = open_in ("libmincaml.S") in
      write_library oc inchan;
    close_in inchan);
*)
(* (* ppc *)
  Printf.fprintf oc "\tlwz\tr1, 0(r1)\n";
  Printf.fprintf oc "\tlwz\tr0, 8(r1)\n";
  Printf.fprintf oc "\tmtlr\tr0\n";
  Printf.fprintf oc "\tlmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tblr\n"
*)
(* (* Asm.CPUAsm.Core*)
  Printf.fprintf oc "\tld\tr1, r1, 0\n";
  Printf.fprintf oc "\tld\tr0, r1, 8\n";
  Printf.fprintf oc "\tmtlr\tr0\n";
  Printf.fprintf oc "\tlmw\tr30, r1, -8\n";
  Printf.fprintf oc "\tblr\n"
*)
*)
