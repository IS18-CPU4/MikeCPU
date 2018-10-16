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
                         (Typing.f
                            (Parser.exp Lexer.token l)))))))))

let string s = lexbuf stdout (Lexing.from_string s) (* 文字列をコンパイルして標準出力に表示する (caml2html: main_string) *)

(* 課題１ *)
let dump_bool = ref false

let dump_lexbuf outchan l = (* lexbufの改造 (caml2html: main_lexbuf) *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  let syntax = Parser.exp Lexer.token l in
  let _ = print_newline in
  let _ = print_endline "Syntax.t" in
  let _ = PrintSyntax.print_syntax_t syntax in
  let _ = print_newline () in
  let _ = print_endline "KNormal.t" in
  let normal = KNormal.f (Typing.f syntax) in
  let _ = PrintKNormal.print_knormal_t normal in
  let _ = print_newline () in
  let _ = print_endline "Alpha.t" in
  let alpha = Alpha.f normal in
  let _ = PrintKNormal.print_knormal_t alpha in
  let _ = print_newline () in
  let _ = print_endline "Cse.t" in
  let cse = Cse.f alpha in
  let _ = PrintKNormal.print_knormal_t cse in
  let _ = print_newline () in
  Emit.f outchan
    (RegAlloc.f
       (Simm.f
          (Virtual.f
             (Closure.f
                (iter !limit
                   (cse))))))

(* ここまで *)

let file f = (* ファイルをコンパイルしてファイルに出力する (caml2html: main_file) *)
  let inchan = open_in (f ^ ".ml") in
  let outchan = open_out (f ^ ".s") in
  try
    let _ = if !dump_bool then (*ここで -dump の実行*)
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
    | e -> (close_in inchan; close_out outchan; raise e)




let () = (* ここからコンパイラの実行が開始される (caml2html: main_entry) *)
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated");
     ("-dump", Arg.Unit(fun () -> dump_bool := true), "intermediate result output")] (* Syntax.tやKNormal.t表示用オプション *)
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-iter n] [-dump s|k|a|c] ...filenames without \".ml\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files
