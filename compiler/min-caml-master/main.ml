let limit = ref 1000

let rec iter n e = (* 最適化処理をくりかえす (caml2html: main_iter) *)
  Format.eprintf "iteration %d@." n;
  if n = 0 then e else
  let e' = Elim.f (ConstFold.f (Inline.f (Assoc.f (Beta.f e)))) in
  if e = e' then e else
  iter (n - 1) e'

let lexbuf outchan l = (* バッファをコンパイルしてチャンネルへ出力する (caml2html: main_lexbuf) *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  Emit.f outchan
    (RegAlloc.f
       (Simm.f
          (Virtual.f
             (Closure.f
                (iter !limit
                   (Alpha.f
                      (KNormal.f
                         (Syntax2.remove_pos
                           (Typing.f
                             (Parser.exp Lexer.token l))))))))))

let string s = lexbuf stdout (Lexing.from_string s) (* 文字列をコンパイルして標準出力に表示する (caml2html: main_string) *)

(* デバッグ出力フラグ *)
let dump_bool = ref false
let dump_syntax = ref false
let dump_knormal = ref false
let dump_alpha = ref false
let dump_cse = ref false
let dump_cls = ref false
let dump_asm = ref false
let dump_reg = ref false
(* globals.sのソースを埋め込むかの管理フラグ *)
let global_bool = ref false

let rec pre_dump_bools op n =
  if n = 0 then dump_bool := !dump_syntax || !dump_knormal || !dump_alpha || !dump_cse || !dump_cls || !dump_asm || !dump_reg
  else
    match String.get op (n - 1) with
      | 's' -> dump_syntax := true; pre_dump_bools op (n-1)
      | 'k' -> dump_knormal := true; pre_dump_bools op (n-1)
      | 'a' -> dump_alpha := true; pre_dump_bools op (n-1)
      | 'c' -> dump_cse := true; pre_dump_bools op (n-1)
      | 'x' -> dump_cls := true; pre_dump_bools op (n-1)
      | 'm' -> dump_asm := true; pre_dump_bools op (n-1)
      | 'r' -> dump_reg := true; pre_dump_bools op (n-1)
      | _ -> raise (Arg.Bad("invalid option -dump needs s|k|a|c|m|r "))

let rec dump_bools op =
  let n = String.length op in
    pre_dump_bools op n

(* ファイル書き込み　実質cpコマンド *)
let rec write_file inchan outchan last_message =
  try
    let s = input_line inchan in
      output_string outchan (s^"\n");
    write_file inchan outchan last_message
  with
    e -> output_string outchan last_message

(* ファイル結合 *)
let file_concat inchan1 inchan2 outchan =
  write_file inchan1 outchan "(** End Global**)\n\n\n";
  write_file inchan2 outchan ""


let dump_lexbuf outchan l = (* lexbufもどき *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  let syntax = Parser.exp Lexer.token l in
  let _ = if !dump_syntax then
    let _ = print_newline in
    let _ = print_endline "Syntax.t" in
    let _ = print_endline "==============================================" in
    let _ = PrintSyntax.print_syntax_t (Syntax2.remove_pos syntax) in
      print_endline "=============================================="
    else ()
  in let normal = KNormal.f (Syntax2.remove_pos (Typing.f syntax)) in
  let _ = if !dump_knormal then
    let _ = print_newline () in
    let _ = print_endline "KNormal.t" in
    let _ = print_endline "==============================================" in
    let _ = PrintKNormal.print_knormal_t normal in
      print_endline "=============================================="
    else ()
  in let alpha = Alpha.f normal in
  let _ = if !dump_alpha then
    let _ = print_newline () in
    let _ = print_endline "Alpha.t" in
    let _ = print_endline "==============================================" in
    let _ = PrintKNormal.print_knormal_t alpha in
      print_endline "=============================================="
    else ()
    in let cse = alpha (* cseしないためのでっち上げ *)
(*
  in let cse = Cse.f alpha in
  let _ = if !dump_cse then
    let _ = print_newline () in
    let _ = print_endline "Cse.t" in
    let _ = print_endline "==============================================" in
    let _ = PrintKNormal.print_knormal_t cse in
      print_endline "=============================================="
*)
  in let cls = (Closure.f
                (iter !limit
                  (cse))) in
  let _ = if !dump_cls then
    let _ = print_newline () in
    let _ = print_endline "Closure.prog" in
    let _ = print_endline "==============================================" in
    let _ = PrintClosure.print_closure_prog cls in
      print_endline "=============================================="
    else ()
  in let vir = Virtual.f cls in
  let _ = if !dump_asm then
    let _ = print_newline () in
    let _ = print_endline "Asm.prog" in
    let _ = print_endline "==============================================" in
    let _ = PrintCPUCoreAsm.print_asm_prog vir in
      print_endline "=============================================="
  in let ra = RegAlloc.f
                (Simm.f
                  (vir)) in
  let _ = if !dump_reg then
    let _ = print_newline () in
    let _ = print_endline "RegAlloc.prog" in
    let _ = print_endline "==============================================" in
    let _ = PrintCPUCoreAsm.print_asm_prog ra in
      print_endline "=============================================="
  in let _ = print_newline () in
  Emit.f outchan
    (ra)

let file f = (* ファイルをコンパイルしてファイルに出力する (caml2html: main_file) *)
(*
  let inchan = open_in (f ^ ".ml") in
  let outchan = open_out (f ^ ".s") in
*)
  let inchan = if !global_bool then
                 let original_inchan = open_in (f ^ ".ml") in
                 let globals_inchan = open_in "min-rt/globals.s" in
                 let globals_outchan = open_out (f ^ "_globals.ml") in
                 let _ = file_concat globals_inchan original_inchan globals_outchan in
                 let _ = close_in original_inchan in
                 let _ = close_in globals_inchan in
                 let _ = close_out globals_outchan in
                   open_in (f ^ "_globals.ml")
               else
                 open_in (f ^ ".ml")
               in
  let outchan = open_out (f ^ ".s") in
  try
    let _ = if !dump_bool then
      dump_lexbuf outchan (Lexing.from_channel inchan)
    else
      lexbuf outchan (Lexing.from_channel inchan)
    in
    close_in inchan;
    close_out outchan;
  with
    | Typing.Error (_, _, _, err_line, err_start, err_end) -> (close_in inchan;
                                 close_out outchan;
                                 failwith ("Type Error near line" ^
                                            string_of_int err_line ^
                                            ", characters " ^
                                            string_of_int err_start ^
                                            "-" ^
                                            string_of_int err_end))
    | e -> (close_in inchan; close_out outchan; raise e)




let () = (* ここからコンパイラの実行が開始される (caml2html: main_entry) *)
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated");
(*   ("-dump", Arg.Unit(fun () -> dump_bool := true), "intermediate result output")]  *)
     ("-nonlib", Arg.Unit(fun () -> Emit.lib_bool := false), "don't paste libmincaml.S into assembly");
     ("-global", Arg.Unit(fun () -> global_bool := true), "using global.s (paste global.s in codes)");
     ("-dump", Arg.String(fun op -> dump_bools op), "intermediate result output")] (* Syntax.tやKNormal.tなどの標準出力 *)
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-iter n] [-dump s|k|a|c|x|m|r] [-nonlib] [-global] ...filenames without \".ml\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files
