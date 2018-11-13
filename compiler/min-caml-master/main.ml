let limit = ref 1000

let rec iter n e = (* ��Ŭ�������򤯤꤫���� (caml2html: main_iter) *)
  Format.eprintf "iteration %d@." n;
  if n = 0 then e else
  let e' = Elim.f (ConstFold.f (Inline.f (Assoc.f (Beta.f e)))) in
  if e = e' then e else
  iter (n - 1) e'

let lexbuf outchan l = (* �Хåե��򥳥��ѥ��뤷�ƥ������ͥ��ؽ��Ϥ��� (caml2html: main_lexbuf) *)
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
                         (Typing.f
                            (Parser.exp Lexer.token l)))))))))

let string s = lexbuf stdout (Lexing.from_string s) (* ʸ�����򥳥��ѥ��뤷��ɸ�����Ϥ�ɽ������ (caml2html: main_string) *)

(* ���꣱ *)
let dump_bool = ref false
let dump_syntax = ref false
let dump_knormal = ref false
let dump_alpha = ref false
let dump_cse = ref false

let rec pre_dump_bools op n =
  if n = 0 then dump_bool := !dump_syntax || !dump_knormal || !dump_alpha || !dump_cse
  else
    match String.get op (n - 1) with
      | 's' -> dump_syntax := true; pre_dump_bools op (n-1)
      | 'k' -> dump_knormal := true; pre_dump_bools op (n-1)
      | 'a' -> dump_alpha := true; pre_dump_bools op (n-1)
      | 'c' -> dump_cse := true; pre_dump_bools op (n-1)
      | _ -> raise (Arg.Bad("invalid option -dump needs s|k|a|c "))

let rec dump_bools op =
  let n = String.length op in
    pre_dump_bools op n


let dump_lexbuf outchan l = (* lexbuf�β�¤ (caml2html: main_lexbuf) *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  let syntax = Parser.exp Lexer.token l in
  let _ = if !dump_syntax then
    let _ = print_newline in
    let _ = print_endline "Syntax.t" in
    let _ = print_endline "==============================================" in
    let _ = PrintSyntax.print_syntax_t syntax in
      print_endline "=============================================="
    else ()
  in let normal = KNormal.f (Typing.f syntax) in
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
  in let cse = Cse.f alpha in
  let _ = if !dump_cse then
    let _ = print_newline () in
    let _ = print_endline "Cse.t" in
    let _ = print_endline "==============================================" in
    let _ = PrintKNormal.print_knormal_t cse in
      print_endline "=============================================="
  in let _ = print_newline () in
  Emit.f outchan
    (RegAlloc.f
       (Simm.f
          (Virtual.f
             (Closure.f
                (iter !limit
                   (cse))))))

(* �����ޤ� *)

let file f = (* �ե������򥳥��ѥ��뤷�ƥե������˽��Ϥ��� (caml2html: main_file) *)
  let inchan = open_in (f ^ ".ml") in
  let outchan = open_out (f ^ ".s") in
  try
    let _ = if !dump_bool then (*������ -dump �μ¹�*)
      dump_lexbuf outchan (Lexing.from_channel inchan)
    else
      lexbuf outchan (Lexing.from_channel inchan)
    in
    close_in inchan;
    close_out outchan;
  with
(*    | Typing.Error (_, _, _) -> (close_in inchan;
                                 close_out outchan;
                                 failwith ("Type Error near line" ^
                                            string_of_int aaa ^
                                            ", characters " ^
                                            string_of_int aaa ^
                                            "-" ^
                                            string_of_int aaa)) *)
    | e -> (close_in inchan; close_out outchan;print_endline "hoge"; print_endline "fuga"; raise e)




let () = (* �������饳���ѥ����μ¹Ԥ����Ϥ����� (caml2html: main_entry) *)
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated");
(*   ("-dump", Arg.Unit(fun () -> dump_bool := true), "intermediate result output")] (* Syntax.t��KNormal.tɽ���ѥ��ץ����� *) *)
     ("-dump", Arg.String(fun op -> dump_bools op), "intermediate result output")] (* Syntax.t��KNormal.tɽ���ѥ��ץ����� *)
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-iter n] [-dump s|k|a|c] ...filenames without \".ml\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files
