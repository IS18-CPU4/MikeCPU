%{
(* parserが利用する変数、関数、型などの定義 *)
open Syntax
let addtyp (x, _, _, _) = (x, Type.gentyp ())
%}

/* (* 字句を表すデータ型の定義 (caml2html: parser_token) *) */
%token <bool * int * int * int> BOOL
%token <int * int * int * int> INT
%token <float * int * int * int> FLOAT
%token <int * int * int> NOT
%token <int * int * int> MINUS
%token <int * int * int> PLUS
%token <int * int * int> AST
%token <int * int * int> SLASH
%token <int * int * int> MINUS_DOT
%token <int * int * int> PLUS_DOT
%token <int * int * int> AST_DOT
%token <int * int * int> SLASH_DOT
%token <int * int * int> EQUAL
%token <int * int * int> LESS_GREATER
%token <int * int * int> LESS_EQUAL
%token <int * int * int> GREATER_EQUAL
%token <int * int * int> LESS
%token <int * int * int> GREATER
%token <int * int * int> FUNFLESS
%token <int * int * int> FUNFEQUAL
%token <int * int * int> FUNFNEG
%token <int * int * int> IF
%token <int * int * int> THEN
%token <int * int * int> ELSE
%token <Id.t * int * int * int> IDENT
%token <int * int * int> LET
%token <int * int * int> IN
%token <int * int * int> REC
%token <int * int * int> COMMA
%token <int * int * int> ARRAY_CREATE
%token <int * int * int> DOT
%token <int * int * int> LESS_MINUS
%token <int * int * int> SEMICOLON
%token <int * int * int> LPAREN
%token <int * int * int> RPAREN
%token EOF

/* (* 優先順位とassociativityの定義（低い方から高い方へ） (caml2html: parser_prior) *) */
%nonassoc IN
%right prec_let
%right SEMICOLON
%right prec_if
%right LESS_MINUS
%nonassoc prec_tuple
%left COMMA
%left EQUAL LESS_GREATER LESS GREATER LESS_EQUAL GREATER_EQUAL FUNFLESS FUNFEQUAL
%left PLUS MINUS PLUS_DOT MINUS_DOT FUNFNEG
%left AST SLASH AST_DOT SLASH_DOT
%right prec_unary_minus
%left prec_app
%left DOT

/* (* 開始記号の定義 *) */
%type <Syntax.t> exp
%start exp

%%

simple_exp: /* (* 括弧をつけなくても関数の引数になれる式 (caml2html: parser_simple) *) */
| LPAREN exp RPAREN
    { $2 }
| LPAREN RPAREN
    {
      let (pos_line, pos_start, _) = $1 in
        Unit(pos_line, pos_start, pos_start + 1)
    }
| BOOL
    {
    let (flag, line, start, p_end) = $1 in
      Bool(flag, line, start, p_end)
    }
| INT
    {
    let (num, line, start, p_end) = $1 in
      Int(num, line, start, p_end)
    }
| FLOAT
    {
      let (num, line, start, p_end) = $1 in
        Float(num, line, start, p_end)
    }
| IDENT
    {
      let (id, line, start, p_end) = $1 in
        Var(id, line, start, p_end)
    }
| simple_exp DOT LPAREN exp RPAREN
    {
      let (line, start, _) = get_pos $1 in
      let (_, _, p_end) = $5 in
        Get($1, $4, line, start, p_end)
    }

exp: /* (* 一般の式 (caml2html: parser_exp) *) */
| simple_exp
    { $1 }
| NOT exp
    %prec prec_app
    {
      let (line, start, p_end) = $1 in
        Not($2, line, start, p_end)
    }
| MINUS exp
    %prec prec_unary_minus
    {
    let (line, start, p_end) = $1 in
      match $2 with
       | Float(f, _, _, f_end) -> Float(-.f, line, start, f_end) (* -1.23などは型エラーではないので別扱い *)
       | e -> Neg(e, line, start, p_end)
    }
| exp PLUS exp /* (* 足し算を構文解析するルール (caml2html: parser_add) *) */
    {
      let (line, start, p_end) = $2 in
        Add($1, $3, line, start, p_end)
    }
| exp MINUS exp
    {
      let (line, start, p_end) = $2 in
        Sub($1, $3, line, start, p_end)
    }
| exp AST exp /* (* 掛け算（左シフト）を構文解析するルール *) */
    {
      let (line, start, p_end) = $2 in
        Mul($1, $3, line, start, p_end)
    }
| exp SLASH exp
    {
      let (line, start, p_end) = $2 in
        Div($1, $3, line, start, p_end)
    }
| exp EQUAL exp
    {
      let (line, start, p_end) = $2 in
        Eq($1, $3, line, start, p_end)
    }
| FUNFEQUAL actual_args
    {
      let (line, start, p_end) = $1 in
      let left::ys = $2 in
      match ys with
       | [] -> failwith (Printf.sprintf "parse error near line %d, characters %d-%d fequal needs 2 args"
                           line start p_end)
       | right::[] ->  Eq(left, right, line, start, p_end)
       | _::_ -> failwith (Printf.sprintf "parse error near line %d, characters %d-%d fequal needs 2 args"
                            line start p_end)
    }
| exp LESS_GREATER exp
    {
      let (line, start, p_end) = $2 in
        Not(Eq($1, $3, line, start, p_end), line, start, p_end)
    }
| exp LESS exp
    {
      let (line, start, p_end) = $2 in
        Not(LE($3, $1, line, start, p_end), line, start, p_end)
    }
| FUNFLESS actual_args
    {
      let (line, start, p_end) = $1 in
      let left::ys = $2 in
      match ys with
       | [] -> failwith (Printf.sprintf "parse error near line %d, characters %d-%d fless needs 2 args"
                          line start p_end)
       | right::[] ->  Not(LE(right, left, line, start, p_end), line, start, p_end)
       | _::_ -> failwith (Printf.sprintf "parse error near line %d, characters %d-%d fless needs 2 args"
                            line start p_end)
    }
| exp GREATER exp
    {
      let (line, start, p_end) = $2 in
        Not(LE($1, $3, line, start, p_end), line, start, p_end)
    }
| exp LESS_EQUAL exp
    {
      let (line, start, p_end) = $2 in
        LE($1, $3, line, start, p_end)
    }
| exp GREATER_EQUAL exp
    {
      let (line, start, p_end) = $2 in
        LE($3, $1, line, start, p_end)
    }
| IF exp THEN exp ELSE exp
    %prec prec_if
    {
      let (line, start, p_end) = $1 in
        If($2, $4, $6, line, start, p_end)
    }
| MINUS_DOT exp
    %prec prec_unary_minus
    {
      let (line, start, p_end) = $1 in
        FNeg($2, line, start, p_end)
    }
| FUNFNEG exp
    %prec prec_unary_minus
    {
      let (line, start, p_end) = $1 in
        FNeg($2, line, start, p_end)
    }
| exp PLUS_DOT exp
    {
      let (line, start, p_end) = $2 in
        FAdd($1, $3, line, start, p_end)
    }
| exp MINUS_DOT exp
    {
      let (line, start, p_end) = $2 in
        FSub($1, $3, line, start, p_end)
    }
| exp AST_DOT exp
    {
      let (line, start, p_end) = $2 in
        FMul($1, $3, line, start, p_end)
    }
| exp SLASH_DOT exp
    {
      let (line, start, p_end) = $2 in
        FDiv($1, $3, line, start, p_end)
    }
/* (* min-rt用でっち上げルール。最後を in 0にされた対応*) */
| LET IDENT EQUAL exp IN exp
    %prec prec_let
    {
      match $6 with
        | Int (_) -> $4
        | _ -> let (line, start, p_end) = $1 in
                 Let(addtyp $2, $4, $6, line, start, p_end)
    }
| LET REC fundef IN exp
    %prec prec_let
    {
      let (line, start, p_end) = $1 in
        LetRec($3, $5, line, start, p_end + 3)
    }
| simple_exp actual_args
    %prec prec_app
    {
      let (line, start, p_end) = get_pos $1 in
        App($1, $2, line, start, p_end)
    }
| elems
    %prec prec_tuple
    {
      let start = (Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol in
      let line = (Parsing.symbol_start_pos ()).Lexing.pos_lnum in
      let p_end = (Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol in
        Tuple($1, start, line, p_end)
    }
| LET LPAREN pat RPAREN EQUAL exp IN exp
    {
      let (line, start, p_end) = $1 in
        LetTuple($3, $6, $8, line, start, p_end)
    }
| simple_exp DOT LPAREN exp RPAREN LESS_MINUS exp
    {
      let (line, start, _) = get_pos $1 in
      let (_, _, p_end) = get_pos $7 in
        Put($1, $4, $7, line, start, p_end)
    }
| exp SEMICOLON exp
    {
      let (line, start, p_end) = $2 in
        Let((Id.gentmp Type.Unit, Type.Unit), $1, $3, line, start, p_end)
    }
| exp SEMICOLON /*(* minrt用superでっち上げ ";"のあとに書いてなくても通る実質バグ *)*/
    {
      let (line, start, p_end) = $2 in
        Let((Id.gentmp Type.Unit, Type.Unit), $1, Unit(line, start + 1, p_end + 1), line, start, p_end)
    }
| ARRAY_CREATE simple_exp simple_exp
    %prec prec_app
    {
      let (line, start, p_end) = $1 in
        Array($2, $3, line, start, p_end)
    }
| error
    { failwith
        (let pos_start = (Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol in
         Printf.sprintf "parse error near line %d, characters %d-%d"
           ((Parsing.symbol_end_pos ()).Lexing.pos_lnum)
           pos_start
           (pos_start + 1)) }

fundef:
| IDENT formal_args EQUAL exp
    { { name = addtyp $1; args = $2; body = $4 } }

formal_args:
| IDENT formal_args
    { addtyp $1 :: $2 }
| IDENT
    { [addtyp $1] }

actual_args:
| actual_args simple_exp
    %prec prec_app
    { $1 @ [$2] }
| simple_exp
    %prec prec_app
    { [$1] }

elems:
| elems COMMA exp
    { $1 @ [$3] }
| exp COMMA exp
    { [$1; $3] }

pat:
| pat COMMA IDENT
    { $1 @ [addtyp $3] }
| IDENT COMMA IDENT
    { [addtyp $1; addtyp $3] }
