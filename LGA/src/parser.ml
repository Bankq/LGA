type token =
  | ASSIGN
  | TERMINATOR
  | RETURN
  | STATEMENT of (string)
  | INDENT
  | OUTDENT
  | ARROW
  | LBK
  | RBK
  | LPAREN
  | RPAREN
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | EQ
  | NEQ
  | MOD
  | AND
  | OR
  | LT
  | LEQ
  | GT
  | GEQ
  | NOT
  | COLON
  | LBRACE
  | RBRACE
  | COMMA
  | DOT
  | NULL
  | THIS
  | IF
  | ELSE
  | WHILE
  | FOR
  | FORIN
  | IDENTIFIER of (string)
  | NUM of (float)
  | STRING of (string)
  | OUTDENT_COUNT of (int)
  | BOOL of (bool)
  | EOF

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
open Ast 
# 51 "parser.ml"
let yytransl_const = [|
  257 (* ASSIGN *);
  258 (* TERMINATOR *);
  259 (* RETURN *);
  261 (* INDENT *);
  262 (* OUTDENT *);
  263 (* ARROW *);
  264 (* LBK *);
  265 (* RBK *);
  266 (* LPAREN *);
  267 (* RPAREN *);
  268 (* PLUS *);
  269 (* MINUS *);
  270 (* TIMES *);
  271 (* DIVIDE *);
  272 (* EQ *);
  273 (* NEQ *);
  274 (* MOD *);
  275 (* AND *);
  276 (* OR *);
  277 (* LT *);
  278 (* LEQ *);
  279 (* GT *);
  280 (* GEQ *);
  281 (* NOT *);
  282 (* COLON *);
  283 (* LBRACE *);
  284 (* RBRACE *);
  285 (* COMMA *);
  286 (* DOT *);
  287 (* NULL *);
  288 (* THIS *);
  289 (* IF *);
  290 (* ELSE *);
  291 (* WHILE *);
  292 (* FOR *);
  293 (* FORIN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  260 (* STATEMENT *);
  294 (* IDENTIFIER *);
  295 (* NUM *);
  296 (* STRING *);
  297 (* OUTDENT_COUNT *);
  298 (* BOOL *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\000\000"

let yylen = "\002\000\
\003\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\003\000\002\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\005\000"

let yysindex = "\001\000\
\218\254\000\000\000\000\000\000\002\255\218\254\002\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\004\000\000\000\005\000"

let yygindex = "\000\000\
\002\000"

let yytablesize = 8
let yytable = "\003\000\
\004\000\001\000\006\000\004\000\001\000\000\000\000\000\007\000"

let yycheck = "\038\001\
\039\001\001\000\001\001\000\000\000\000\255\255\255\255\006\000"

let yynames_const = "\
  ASSIGN\000\
  TERMINATOR\000\
  RETURN\000\
  INDENT\000\
  OUTDENT\000\
  ARROW\000\
  LBK\000\
  RBK\000\
  LPAREN\000\
  RPAREN\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  EQ\000\
  NEQ\000\
  MOD\000\
  AND\000\
  OR\000\
  LT\000\
  LEQ\000\
  GT\000\
  GEQ\000\
  NOT\000\
  COLON\000\
  LBRACE\000\
  RBRACE\000\
  COMMA\000\
  DOT\000\
  NULL\000\
  THIS\000\
  IF\000\
  ELSE\000\
  WHILE\000\
  FOR\000\
  FORIN\000\
  EOF\000\
  "

let yynames_block = "\
  STATEMENT\000\
  IDENTIFIER\000\
  NUM\000\
  STRING\000\
  OUTDENT_COUNT\000\
  BOOL\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.expr) in
    Obj.repr(
# 31 "parser.mly"
                       ( Assign(_1, _3))
# 186 "parser.ml"
               : Ast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 32 "parser.mly"
         ( Num(_1) )
# 193 "parser.ml"
               : Ast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 33 "parser.mly"
                ( Id(_1) )
# 200 "parser.ml"
               : Ast.expr))
(* Entry expr *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let expr (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.expr)
