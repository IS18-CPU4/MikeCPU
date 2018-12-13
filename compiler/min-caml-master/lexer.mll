{
(* lexer�����Ѥ����ѿ����ؿ������ʤɤ���� *)
open Parser
open Type
open Lexing
}

(* ����ɽ����ά�� *)
let space = [' ' '\t']
let digit = ['0'-'9']
let lower = ['a'-'z']
let upper = ['A'-'Z']
(* ����1-��������\r\n�Ͼ��space�ˤ��� *)
let enter = ['\n' '\r']

rule token = parse
| space+
    { token lexbuf }
| enter
    { Lexing.new_line lexbuf;
      token lexbuf}
| "(*"
    { comment lexbuf; (* �ͥ��Ȥ��������ȤΤ���Υȥ�å� *)
      token lexbuf }
| '('
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        LPAREN(line, start, l_end)
    }
| ')'
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        RPAREN(line, start, l_end)
    }
| "true"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 4 in
        BOOL(true, line, start, l_end)
    }
| "false"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 5 in
        BOOL(false, line, start, l_end)
     }
| "not"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 3 in
        NOT(line, start, l_end)
    }
(* min-rt��parse���˲���ǽ�ʤ�� fneg, fless, fequal *)
| "fneg"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 4 in
        FUNFNEG(line, start, l_end)
    }
| "fless"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 5 in
        FUNFLESS(line, start, l_end)
    }
| "fequal"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 6 in
        FUNFEQUAL(line, start, l_end)
    }
| digit+ (* �����������Ϥ���롼�� (caml2html: lexer_int) *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let id = Lexing.lexeme lexbuf in
      let l_end = start + Lexing.lexeme_end lexbuf - Lexing.lexeme_end lexbuf in
        INT(int_of_string (id), line, start, l_end)
      (*      INT(int_of_string (Lexing.lexeme lexbuf)) *)
    }
| digit+ ('.' digit*)? (['e' 'E'] ['+' '-']? digit+)?
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let id = Lexing.lexeme lexbuf in
      let l_end = start + Lexing.lexeme_end lexbuf - Lexing.lexeme_end lexbuf in
        FLOAT(float_of_string (id), line, start, l_end)
    (*      FLOAT(float_of_string (Lexing.lexeme lexbuf)) *)
 }
| '-' (* -.����󤷤ˤ��ʤ��Ƥ��ɤ�? ��Ĺ����? *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        MINUS(line, start, l_end)
    }
| '+' (* +.����󤷤ˤ��ʤ��Ƥ��ɤ�? ��Ĺ����? *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        PLUS(line, start, l_end)
    }
| '*' (* *.����󤷤ˤ��ʤ��Ƥ��ɤ�? ��Ĺ����? *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        AST(line, start, l_end)
    }
| '/' (* /.����󤷤ˤ��ʤ��Ƥ��ɤ�? ��Ĺ����? *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        SLASH(line, start, l_end)
    }
(*
| "/"^space*^"2"
    { RSHIFT2 }
*)
| "-."
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        MINUS_DOT(line, start, l_end) }
| "+."
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        PLUS_DOT(line, start, l_end) }
| "*."
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        AST_DOT(line, start, l_end) }
| "/."
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        SLASH_DOT(line, start, l_end) }
| '='
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        EQUAL(line, start, l_end) }
| "<>"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        LESS_GREATER(line, start, l_end) }
| "<="
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        LESS_EQUAL(line, start, l_end) }
| ">="
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        GREATER_EQUAL(line, start, l_end) }
| '<'
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        LESS(line, start, l_end) }
| '>'
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        GREATER(line, start, l_end) }
| "if"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        IF(line, start, l_end) }
| "then"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 4 in
        THEN(line, start, l_end) }
| "else"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 4 in
        ELSE(line, start, l_end) }
| "let"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 3 in
        LET(line, start, l_end) }
| "in"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        IN(line, start, l_end) }
| "rec"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 3 in
        REC(line, start, l_end) }
| ','
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        COMMA(line, start, l_end) }
| '_'
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        IDENT(Id.gentmp Type.Unit, line, start, l_end)
    }
| "create_array"  (* [XX] ad hoc *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 12 in
        ARRAY_CREATE(line, start, l_end)
    }
| "Array.create"  (* [XX] ad hoc *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 12 in
        ARRAY_CREATE(line, start, l_end)
    }
| "Array.make"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 10 in
        ARRAY_CREATE(line, start, l_end)
    }
| '.'
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        DOT(line, start, l_end)
    }
| "<-"
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 2 in
        LESS_MINUS(line, start, l_end)
     }
| ';'
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let l_end = start + 1 in
        SEMICOLON(line, start, l_end)
    }
| eof
    { EOF }
| lower (digit|lower|upper|'_')* (* ¾�Ρ�ͽ���פ���Ǥʤ��Ȥ����ʤ� *)
    {
      let start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in
      let line = lexbuf.lex_curr_p.pos_lnum in
      let id = Lexing.lexeme lexbuf in
      let l_end = start + Lexing.lexeme_end lexbuf - Lexing.lexeme_end lexbuf in
      IDENT(id, line, start, l_end)
    }
| _
    { failwith
        ( let err_start = lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol in (* pos_cnum�Ϲ�Ƭ�Υ����ɤ���Ƭ�����ʸ����, pos_bol�ϸ��߰��֤Υ����ɤ���Ƭ�����ʸ���� *)
          Printf.sprintf "unknown token %s near line %d, characters %d-%d"
           (Lexing.lexeme lexbuf)
           (lexbuf.lex_curr_p.pos_lnum)
           err_start
           (err_start + 1))
(*
           (Lexing.lexeme_start lexbuf)
           (Lexing.lexeme_end lexbuf))
*)
           }
and comment = parse
| "*)"
    { () }
| "(*"
    { comment lexbuf;
      comment lexbuf }
| enter
    { Lexing.new_line lexbuf;
      comment lexbuf}
| eof
    { Format.eprintf "warning: unterminated comment@." }
| _
    { comment lexbuf }
