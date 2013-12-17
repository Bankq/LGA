type token =
  | ASSIGN
  | TERMINATOR
  | RETURN
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
  | BOOL of (string)
  | THIS
  | IF
  | ELSE
  | WHILE
  | FOR
  | FORIN
  | IDENTIFIER of (string)
  | NUM of (string)
  | STRING of (string)
  | STATEMENT of (string)
  | OUTDENT_COUNT of (int)
  | NULL of (string)
  | FUN
  | EOF

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
open Ast 
# 52 "parser.ml"
let yytransl_const = [|
  257 (* ASSIGN *);
  258 (* TERMINATOR *);
  259 (* RETURN *);
  260 (* INDENT *);
  261 (* OUTDENT *);
  262 (* ARROW *);
  263 (* LBK *);
  264 (* RBK *);
  265 (* LPAREN *);
  266 (* RPAREN *);
  267 (* PLUS *);
  268 (* MINUS *);
  269 (* TIMES *);
  270 (* DIVIDE *);
  271 (* EQ *);
  272 (* NEQ *);
  273 (* MOD *);
  274 (* AND *);
  275 (* OR *);
  276 (* LT *);
  277 (* LEQ *);
  278 (* GT *);
  279 (* GEQ *);
  280 (* NOT *);
  281 (* COLON *);
  282 (* LBRACE *);
  283 (* RBRACE *);
  284 (* COMMA *);
  285 (* DOT *);
  287 (* THIS *);
  288 (* IF *);
  289 (* ELSE *);
  290 (* WHILE *);
  291 (* FOR *);
  292 (* FORIN *);
  299 (* FUN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  286 (* BOOL *);
  293 (* IDENTIFIER *);
  294 (* NUM *);
  295 (* STRING *);
  296 (* STATEMENT *);
  297 (* OUTDENT_COUNT *);
  298 (* NULL *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\002\000\002\000\002\000\004\000\004\000\
\006\000\006\000\007\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\011\000\011\000\011\000\011\000\011\000\
\011\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
\011\000\016\000\016\000\010\000\008\000\008\000\008\000\012\000\
\012\000\012\000\018\000\018\000\018\000\018\000\018\000\018\000\
\026\000\026\000\027\000\027\000\025\000\025\000\022\000\022\000\
\029\000\029\000\029\000\029\000\009\000\030\000\030\000\031\000\
\031\000\031\000\031\000\031\000\017\000\017\000\017\000\017\000\
\017\000\028\000\032\000\020\000\020\000\021\000\021\000\003\000\
\003\000\023\000\019\000\019\000\019\000\019\000\024\000\013\000\
\013\000\033\000\033\000\014\000\034\000\015\000\035\000\036\000\
\038\000\037\000\000\000"

let yylen = "\002\000\
\000\000\001\000\002\000\001\000\003\000\002\000\001\000\001\000\
\001\000\001\000\002\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000\001\000\001\000\006\000\001\000\001\000\001\000\003\000\
\004\000\005\000\001\000\001\000\001\000\001\000\002\000\002\000\
\003\000\005\000\001\000\001\000\002\000\001\000\004\000\003\000\
\000\000\001\000\003\000\004\000\002\000\002\000\003\000\001\000\
\003\000\004\000\003\000\005\000\000\000\001\000\003\000\004\000\
\005\000\003\000\001\000\003\000\005\000\002\000\003\000\002\000\
\003\000\001\000\001\000\001\000\001\000\001\000\002\000\001\000\
\003\000\003\000\005\000\002\000\002\000\002\000\002\000\002\000\
\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\086\000\000\000\000\000\000\000\000\000\082\000\083\000\084\000\
\010\000\085\000\000\000\099\000\000\000\000\000\004\000\007\000\
\008\000\009\000\000\000\000\000\014\000\015\000\016\000\017\000\
\018\000\019\000\000\000\000\000\038\000\039\000\043\000\044\000\
\045\000\046\000\000\000\000\000\000\000\000\000\011\000\080\000\
\000\000\000\000\078\000\064\000\000\000\000\000\000\000\033\000\
\051\000\052\000\058\000\000\000\000\000\087\000\000\000\093\000\
\097\000\096\000\000\000\000\000\003\000\000\000\000\000\000\000\
\047\000\054\000\061\000\048\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\092\000\094\000\000\000\095\000\081\000\
\000\000\079\000\000\000\000\000\076\000\000\000\000\000\000\000\
\056\000\090\000\000\000\070\000\005\000\075\000\000\000\062\000\
\000\000\053\000\020\000\021\000\022\000\023\000\024\000\025\000\
\026\000\027\000\028\000\029\000\030\000\031\000\032\000\000\000\
\000\000\040\000\000\000\089\000\098\000\067\000\000\000\000\000\
\065\000\000\000\000\000\049\000\055\000\059\000\000\000\000\000\
\000\000\074\000\063\000\041\000\000\000\000\000\066\000\000\000\
\077\000\000\000\000\000\060\000\000\000\000\000\000\000\071\000\
\042\000\091\000\068\000\050\000\036\000\072\000\000\000\073\000"

let yydgoto = "\002\000\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\030\000\031\000\032\000\033\000\034\000\035\000\
\107\000\036\000\037\000\038\000\039\000\040\000\041\000\042\000\
\073\000\059\000\060\000\074\000\061\000\075\000\053\000\111\000\
\043\000\044\000\045\000\046\000\095\000\066\000"

let yysindex = "\065\000\
\092\000\000\000\011\255\212\255\190\000\133\000\011\255\235\254\
\000\000\030\255\011\255\011\255\030\255\000\000\000\000\000\000\
\000\000\000\000\065\255\000\000\077\255\086\255\000\000\000\000\
\000\000\000\000\056\255\051\255\000\000\000\000\000\000\000\000\
\000\000\000\000\191\255\091\255\000\000\000\000\000\000\000\000\
\000\000\000\000\070\255\114\255\114\255\083\255\000\000\000\000\
\020\255\008\001\000\000\000\000\054\255\153\000\021\255\000\000\
\000\000\000\000\000\000\097\255\009\255\000\000\114\255\000\000\
\000\000\000\000\030\255\153\000\000\000\085\255\227\000\030\255\
\000\000\000\000\000\000\000\000\011\255\011\255\011\255\011\255\
\011\255\011\255\011\255\011\255\011\255\011\255\011\255\011\255\
\011\255\150\255\008\255\000\000\000\000\011\255\000\000\000\000\
\255\254\000\000\192\255\071\255\000\000\045\001\044\255\235\254\
\000\000\000\000\058\255\000\000\000\000\000\000\116\255\000\000\
\059\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\011\255\
\011\255\000\000\011\255\000\000\000\000\000\000\011\255\008\001\
\000\000\115\255\011\255\000\000\000\000\000\000\089\255\122\255\
\015\255\000\000\000\000\000\000\125\255\114\255\000\000\016\255\
\000\000\126\255\235\254\000\000\114\255\030\255\030\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\042\255\000\000"

let yyrindex = "\000\000\
\132\000\000\000\000\000\000\000\000\000\000\000\000\000\024\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\134\000\000\000\000\000\000\000\
\000\000\000\000\029\000\056\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
\000\000\000\000\083\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\062\255\084\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\095\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\050\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\003\000\226\255\067\000\027\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\230\255\000\000\000\000\000\000\000\000\000\000\248\255\254\255\
\108\000\161\255\000\000\000\000\034\000\000\000\209\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yytablesize = 600
let yytable = "\057\000\
\037\000\062\000\097\000\134\000\065\000\058\000\049\000\142\000\
\055\000\010\000\103\000\004\000\104\000\092\000\093\000\014\000\
\158\000\005\000\159\000\006\000\163\000\068\000\068\000\113\000\
\096\000\057\000\099\000\057\000\012\000\047\000\101\000\052\000\
\106\000\056\000\007\000\105\000\008\000\063\000\064\000\131\000\
\009\000\010\000\011\000\099\000\012\000\013\000\168\000\014\000\
\015\000\016\000\057\000\014\000\018\000\019\000\069\000\013\000\
\100\000\070\000\108\000\142\000\132\000\098\000\070\000\114\000\
\071\000\001\000\014\000\144\000\147\000\145\000\141\000\069\000\
\068\000\067\000\010\000\138\000\052\000\069\000\068\000\072\000\
\014\000\099\000\088\000\006\000\072\000\145\000\099\000\069\000\
\152\000\069\000\155\000\090\000\104\000\156\000\057\000\057\000\
\057\000\052\000\057\000\057\000\058\000\058\000\091\000\115\000\
\116\000\117\000\118\000\119\000\120\000\121\000\122\000\123\000\
\124\000\125\000\126\000\127\000\130\000\004\000\094\000\162\000\
\133\000\102\000\110\000\146\000\153\000\137\000\165\000\157\000\
\140\000\161\000\164\000\001\000\167\000\002\000\109\000\076\000\
\160\000\143\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\057\000\000\000\000\000\166\000\108\000\128\000\
\058\000\129\000\148\000\149\000\005\000\150\000\006\000\000\000\
\000\000\151\000\052\000\000\000\000\000\154\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\007\000\000\000\008\000\
\000\000\000\000\000\000\009\000\010\000\011\000\000\000\012\000\
\013\000\000\000\014\000\015\000\016\000\000\000\000\000\018\000\
\019\000\135\000\000\000\136\000\000\000\000\000\005\000\000\000\
\006\000\077\000\078\000\079\000\080\000\081\000\082\000\083\000\
\084\000\085\000\086\000\087\000\088\000\089\000\003\000\007\000\
\048\000\008\000\005\000\000\000\006\000\009\000\010\000\011\000\
\000\000\012\000\013\000\000\000\014\000\015\000\016\000\000\000\
\000\000\018\000\019\000\007\000\000\000\008\000\000\000\000\000\
\000\000\009\000\010\000\011\000\000\000\012\000\013\000\000\000\
\014\000\015\000\016\000\017\000\000\000\018\000\019\000\000\000\
\000\000\000\000\037\000\000\000\037\000\037\000\000\000\037\000\
\037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
\037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
\000\000\000\000\000\000\037\000\037\000\037\000\012\000\000\000\
\012\000\012\000\000\000\000\000\012\000\000\000\012\000\034\000\
\034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
\034\000\034\000\034\000\034\000\000\000\000\000\000\000\012\000\
\012\000\013\000\000\000\013\000\013\000\000\000\000\000\013\000\
\000\000\013\000\035\000\035\000\035\000\035\000\035\000\035\000\
\035\000\035\000\035\000\035\000\035\000\035\000\035\000\000\000\
\000\000\000\000\013\000\013\000\088\000\006\000\088\000\088\000\
\006\000\000\000\088\000\000\000\088\000\006\000\003\000\004\000\
\000\000\000\000\005\000\000\000\006\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\088\000\088\000\000\000\
\000\000\000\000\000\000\007\000\000\000\008\000\000\000\000\000\
\000\000\009\000\010\000\011\000\000\000\012\000\013\000\000\000\
\014\000\015\000\016\000\017\000\000\000\018\000\019\000\003\000\
\054\000\000\000\000\000\005\000\000\000\006\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\003\000\007\000\000\000\008\000\005\000\
\000\000\006\000\009\000\010\000\011\000\000\000\012\000\013\000\
\000\000\014\000\015\000\016\000\017\000\000\000\018\000\019\000\
\007\000\000\000\008\000\000\000\000\000\000\000\009\000\010\000\
\011\000\000\000\012\000\013\000\000\000\014\000\015\000\016\000\
\017\000\050\000\018\000\019\000\005\000\051\000\006\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\007\000\000\000\008\000\
\000\000\000\000\000\000\009\000\010\000\011\000\000\000\012\000\
\013\000\000\000\014\000\015\000\016\000\000\000\050\000\018\000\
\019\000\005\000\000\000\006\000\112\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\007\000\000\000\008\000\000\000\000\000\000\000\
\009\000\010\000\011\000\000\000\012\000\013\000\000\000\014\000\
\015\000\016\000\000\000\050\000\018\000\019\000\005\000\000\000\
\006\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\007\000\
\000\000\008\000\000\000\000\000\000\000\009\000\010\000\011\000\
\000\000\012\000\013\000\000\000\014\000\015\000\016\000\000\000\
\139\000\018\000\019\000\005\000\000\000\006\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\007\000\000\000\008\000\000\000\
\000\000\000\000\009\000\010\000\011\000\000\000\012\000\013\000\
\000\000\014\000\015\000\016\000\000\000\000\000\018\000\019\000"

let yycheck = "\008\000\
\000\000\010\000\050\000\005\001\013\000\008\000\004\000\103\000\
\006\000\031\001\002\001\004\001\004\001\044\000\045\000\037\001\
\002\001\007\001\004\001\009\001\005\001\002\001\002\001\071\000\
\005\001\002\001\028\001\004\001\000\000\003\000\010\001\005\000\
\063\000\007\000\024\001\027\001\026\001\011\000\012\000\032\001\
\030\001\031\001\032\001\028\001\034\001\035\001\005\001\037\001\
\038\001\039\001\027\001\037\001\042\001\043\001\005\001\000\000\
\054\000\007\001\067\000\155\000\091\000\008\001\007\001\072\000\
\009\001\001\000\037\001\010\001\010\001\028\001\027\001\010\001\
\002\001\009\001\031\001\005\001\050\000\028\001\002\001\029\001\
\037\001\028\001\000\000\000\000\029\001\028\001\028\001\002\001\
\136\000\028\001\002\001\001\001\004\001\005\001\103\000\104\000\
\002\001\071\000\004\001\005\001\103\000\104\000\033\001\077\000\
\078\000\079\000\080\000\081\000\082\000\083\000\084\000\085\000\
\086\000\087\000\088\000\089\000\090\000\004\001\036\001\150\000\
\094\000\025\001\038\001\008\001\010\001\099\000\157\000\006\001\
\102\000\005\001\005\001\000\000\159\000\000\000\068\000\028\000\
\145\000\104\000\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\155\000\255\255\255\255\158\000\159\000\002\001\
\155\000\004\001\128\000\129\000\007\001\131\000\009\001\255\255\
\255\255\135\000\136\000\255\255\255\255\139\000\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\024\001\255\255\026\001\
\255\255\255\255\255\255\030\001\031\001\032\001\255\255\034\001\
\035\001\255\255\037\001\038\001\039\001\255\255\255\255\042\001\
\043\001\002\001\255\255\004\001\255\255\255\255\007\001\255\255\
\009\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\019\001\020\001\021\001\022\001\023\001\003\001\024\001\
\005\001\026\001\007\001\255\255\009\001\030\001\031\001\032\001\
\255\255\034\001\035\001\255\255\037\001\038\001\039\001\255\255\
\255\255\042\001\043\001\024\001\255\255\026\001\255\255\255\255\
\255\255\030\001\031\001\032\001\255\255\034\001\035\001\255\255\
\037\001\038\001\039\001\040\001\255\255\042\001\043\001\255\255\
\255\255\255\255\002\001\255\255\004\001\005\001\255\255\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001\023\001\
\255\255\255\255\255\255\027\001\028\001\029\001\002\001\255\255\
\004\001\005\001\255\255\255\255\008\001\255\255\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\021\001\022\001\023\001\255\255\255\255\255\255\027\001\
\028\001\002\001\255\255\004\001\005\001\255\255\255\255\008\001\
\255\255\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\021\001\022\001\023\001\255\255\
\255\255\255\255\027\001\028\001\002\001\002\001\004\001\005\001\
\005\001\255\255\008\001\255\255\010\001\010\001\003\001\004\001\
\255\255\255\255\007\001\255\255\009\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\027\001\028\001\255\255\
\255\255\255\255\255\255\024\001\255\255\026\001\255\255\255\255\
\255\255\030\001\031\001\032\001\255\255\034\001\035\001\255\255\
\037\001\038\001\039\001\040\001\255\255\042\001\043\001\003\001\
\004\001\255\255\255\255\007\001\255\255\009\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\003\001\024\001\255\255\026\001\007\001\
\255\255\009\001\030\001\031\001\032\001\255\255\034\001\035\001\
\255\255\037\001\038\001\039\001\040\001\255\255\042\001\043\001\
\024\001\255\255\026\001\255\255\255\255\255\255\030\001\031\001\
\032\001\255\255\034\001\035\001\255\255\037\001\038\001\039\001\
\040\001\004\001\042\001\043\001\007\001\008\001\009\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\024\001\255\255\026\001\
\255\255\255\255\255\255\030\001\031\001\032\001\255\255\034\001\
\035\001\255\255\037\001\038\001\039\001\255\255\004\001\042\001\
\043\001\007\001\255\255\009\001\010\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\024\001\255\255\026\001\255\255\255\255\255\255\
\030\001\031\001\032\001\255\255\034\001\035\001\255\255\037\001\
\038\001\039\001\255\255\004\001\042\001\043\001\007\001\255\255\
\009\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\024\001\
\255\255\026\001\255\255\255\255\255\255\030\001\031\001\032\001\
\255\255\034\001\035\001\255\255\037\001\038\001\039\001\255\255\
\004\001\042\001\043\001\007\001\255\255\009\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\024\001\255\255\026\001\255\255\
\255\255\255\255\030\001\031\001\032\001\255\255\034\001\035\001\
\255\255\037\001\038\001\039\001\255\255\255\255\042\001\043\001"

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
  THIS\000\
  IF\000\
  ELSE\000\
  WHILE\000\
  FOR\000\
  FORIN\000\
  FUN\000\
  EOF\000\
  "

let yynames_block = "\
  BOOL\000\
  IDENTIFIER\000\
  NUM\000\
  STRING\000\
  STATEMENT\000\
  OUTDENT_COUNT\000\
  NULL\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 35 "parser.mly"
                 ( [] )
# 427 "parser.ml"
               : Ast.root))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 36 "parser.mly"
        ( _1 )
# 434 "parser.ml"
               : Ast.root))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'block) in
    Obj.repr(
# 37 "parser.mly"
                    ( _1 )
# 441 "parser.ml"
               : Ast.root))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'line) in
    Obj.repr(
# 40 "parser.mly"
        ( [_1] )
# 448 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'body) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'line) in
    Obj.repr(
# 41 "parser.mly"
                        ( List.append _1 [_3] )
# 456 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'body) in
    Obj.repr(
# 42 "parser.mly"
                   ( _1 )
# 463 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 45 "parser.mly"
              ( ExpressionLine(_1) )
# 470 "parser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'statement) in
    Obj.repr(
# 46 "parser.mly"
             ( StatementLine(_1) )
# 477 "parser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'return) in
    Obj.repr(
# 49 "parser.mly"
          ( ReturnStatement(_1) )
# 484 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "parser.mly"
             ( LiteralStatement(Literal(_1)) )
# 491 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 53 "parser.mly"
                     ( Return(_2) )
# 498 "parser.ml"
               : 'return))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 56 "parser.mly"
         ( ValueExpression(_1) )
# 505 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'invocation) in
    Obj.repr(
# 57 "parser.mly"
              ( InvocationExpression(_1) )
# 512 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'code) in
    Obj.repr(
# 58 "parser.mly"
        ( CodeExpression(_1) )
# 519 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'operation) in
    Obj.repr(
# 59 "parser.mly"
             ( OperationExpression(_1) )
# 526 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assign) in
    Obj.repr(
# 60 "parser.mly"
          ( AssignExpression(_1) )
# 533 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'iftype) in
    Obj.repr(
# 61 "parser.mly"
          ( IfExpression(_1) )
# 540 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'whiletype) in
    Obj.repr(
# 62 "parser.mly"
             ( WhileExpression(_1) )
# 547 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'fortype) in
    Obj.repr(
# 63 "parser.mly"
           ( ForExpression(_1) )
# 554 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 66 "parser.mly"
                        ( Binop(_1, Plus,_3) )
# 562 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 67 "parser.mly"
                         ( Binop(_1, Minus, _3) )
# 570 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 68 "parser.mly"
                         ( Binop(_1, Times, _3) )
# 578 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 69 "parser.mly"
                          ( Binop(_1, Divide, _3))
# 586 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 70 "parser.mly"
                      ( Binop(_1, Eq, _3) )
# 594 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 71 "parser.mly"
                       ( Binop(_1, Neq, _3) )
# 602 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 72 "parser.mly"
                       ( Binop(_1, Mod, _3) )
# 610 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 73 "parser.mly"
                       ( Binop(_1, And, _3) )
# 618 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 74 "parser.mly"
                          ( Binop(_1, Or, _3) )
# 626 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 75 "parser.mly"
                          ( Binop(_1, Less, _3) )
# 634 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 76 "parser.mly"
                       ( Binop(_1, Leq, _3) )
# 642 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 77 "parser.mly"
                          ( Binop(_1, Greater, _3) )
# 650 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 78 "parser.mly"
                       ( Binop(_1, Geq, _3) )
# 658 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 79 "parser.mly"
                    ( Neg(_2) )
# 665 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 82 "parser.mly"
         ( ValueLop(_1) )
# 672 "parser.ml"
               : 'lop))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'invocation) in
    Obj.repr(
# 83 "parser.mly"
              ( InvocationLop(_1) )
# 679 "parser.ml"
               : 'lop))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'paramList) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 86 "parser.mly"
                                           ( Code(_3, _6) )
# 687 "parser.ml"
               : 'code))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assignable) in
    Obj.repr(
# 89 "parser.mly"
                 ( AssignableValue(_1) )
# 694 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 90 "parser.mly"
           ( LiteralValue(_1) )
# 701 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'parenthetical) in
    Obj.repr(
# 91 "parser.mly"
                 ( ParentheticalValue(_1) )
# 708 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'assignable) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 94 "parser.mly"
                                               ( Assign (_1, _3) )
# 716 "parser.ml"
               : 'assign))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'assignable) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 95 "parser.mly"
                                               ( Assign (_1, _4) )
# 724 "parser.ml"
               : 'assign))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'assignable) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 96 "parser.mly"
                                               ( Assign (_1, _4) )
# 732 "parser.ml"
               : 'assign))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'array) in
    Obj.repr(
# 99 "parser.mly"
         ( ArrayAssignable(_1) )
# 739 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'obj) in
    Obj.repr(
# 100 "parser.mly"
       ( ObjAssignable(_1) )
# 746 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 101 "parser.mly"
              ( IdentifierAssignable(_1) )
# 753 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'thisProperty) in
    Obj.repr(
# 102 "parser.mly"
                ( ThisPropertyAssignable(_1) )
# 760 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'value) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'accessor) in
    Obj.repr(
# 103 "parser.mly"
                  ( ValueAccessorAssignable(_1, _2) )
# 768 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'invocation) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'accessor) in
    Obj.repr(
# 104 "parser.mly"
                       ( InvocationAccessorAssignable(_1, _2) )
# 776 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'objAssignable) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 107 "parser.mly"
                                  ( AssignObj(_1, _3) )
# 784 "parser.ml"
               : 'assignObj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'objAssignable) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 108 "parser.mly"
                                                 ( AssignObj(_1, _4) )
# 792 "parser.ml"
               : 'assignObj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 111 "parser.mly"
              ( IdentifierObjAssignable(_1))
# 799 "parser.ml"
               : 'objAssignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'thisProperty) in
    Obj.repr(
# 112 "parser.mly"
                ( ThisPropertyObjAssignable(_1) )
# 806 "parser.ml"
               : 'objAssignable))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 115 "parser.mly"
                  ( DotAccessor(_2) )
# 813 "parser.ml"
               : 'accessor))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'index) in
    Obj.repr(
# 116 "parser.mly"
         ( IndexAccessor(_1) )
# 820 "parser.ml"
               : 'accessor))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'assignList) in
    Obj.repr(
# 119 "parser.mly"
                                          ( Object(_2) )
# 827 "parser.ml"
               : 'obj))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'assignList) in
    Obj.repr(
# 120 "parser.mly"
                               ( Object(_2) )
# 834 "parser.ml"
               : 'obj))
; (fun __caml_parser_env ->
    Obj.repr(
# 123 "parser.mly"
                 ( [] )
# 840 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assignObj) in
    Obj.repr(
# 124 "parser.mly"
             ( [_1] )
# 847 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'assignList) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'assignObj) in
    Obj.repr(
# 125 "parser.mly"
                                   ( List.append _1 [_3] )
# 855 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'assignList) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'assignList) in
    Obj.repr(
# 127 "parser.mly"
                                        ( List.append _1 _3 )
# 863 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'value) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'arguments) in
    Obj.repr(
# 130 "parser.mly"
                   ( Invocation(_1, _2) )
# 871 "parser.ml"
               : 'invocation))
; (fun __caml_parser_env ->
    Obj.repr(
# 133 "parser.mly"
                 ( [] )
# 877 "parser.ml"
               : 'arguments))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 134 "parser.mly"
                         ( _2 )
# 884 "parser.ml"
               : 'arguments))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 137 "parser.mly"
              ( [_1] )
# 891 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'argList) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 138 "parser.mly"
                            ( List.append _1 [_3] )
# 899 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'argList) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 139 "parser.mly"
                                       ( List.append _1 [_4] )
# 907 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 140 "parser.mly"
                          ( _2 )
# 914 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'argList) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 141 "parser.mly"
                                        ( List.append _1 _4 )
# 922 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    Obj.repr(
# 144 "parser.mly"
                  ( [] )
# 928 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 145 "parser.mly"
              ( [_1] )
# 935 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'paramList) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 146 "parser.mly"
                              ( List.append _1 [_3] )
# 943 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'paramList) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 147 "parser.mly"
                                         ( List.append _1 [_4] )
# 951 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'paramList) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'paramList) in
    Obj.repr(
# 148 "parser.mly"
                                            (List.append _1 _4 )
# 959 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'indexValue) in
    Obj.repr(
# 151 "parser.mly"
                      ( Index(_2) )
# 966 "parser.ml"
               : 'index))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 154 "parser.mly"
       ( Literal(_1) )
# 973 "parser.ml"
               : 'indexValue))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'body) in
    Obj.repr(
# 157 "parser.mly"
                      ( Parenthetical(_2) )
# 980 "parser.ml"
               : 'parenthetical))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'body) in
    Obj.repr(
# 158 "parser.mly"
                                     ( Parenthetical(_3) )
# 987 "parser.ml"
               : 'parenthetical))
; (fun __caml_parser_env ->
    Obj.repr(
# 161 "parser.mly"
              ( [] )
# 993 "parser.ml"
               : 'array))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 162 "parser.mly"
                      ( _2 )
# 1000 "parser.ml"
               : 'array))
; (fun __caml_parser_env ->
    Obj.repr(
# 165 "parser.mly"
                  ([])
# 1006 "parser.ml"
               : 'block))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'body) in
    Obj.repr(
# 166 "parser.mly"
                       ( _2 )
# 1013 "parser.ml"
               : 'block))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 169 "parser.mly"
              ( Literal(_1) )
# 1020 "parser.ml"
               : 'identifier))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 172 "parser.mly"
        ( Literal(_1) )
# 1027 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 173 "parser.mly"
          ( Literal(_1) )
# 1034 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 174 "parser.mly"
         ( Literal(_1) )
# 1041 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 175 "parser.mly"
         ( Literal(_1) )
# 1048 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 178 "parser.mly"
                      ( _2)
# 1055 "parser.ml"
               : 'thisProperty))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ifBlock) in
    Obj.repr(
# 181 "parser.mly"
                    ( IfOnly(_1) )
# 1062 "parser.ml"
               : 'iftype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'ifBlock) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 182 "parser.mly"
                      ( IfElse(_1, _3) )
# 1070 "parser.ml"
               : 'iftype))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 185 "parser.mly"
                             ( IfBlock(_2, _3) )
# 1078 "parser.ml"
               : 'ifBlock))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'ifBlock) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 186 "parser.mly"
                                    ( IfBlockSeq(_1, _4, _5) )
# 1087 "parser.ml"
               : 'ifBlock))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'whileSource) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 189 "parser.mly"
                      ( While(_1, _2) )
# 1095 "parser.ml"
               : 'whiletype))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 192 "parser.mly"
                     ( WhileSource(_2) )
# 1102 "parser.ml"
               : 'whileSource))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'forBody) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 195 "parser.mly"
                   ( For(_1, _2) )
# 1110 "parser.ml"
               : 'fortype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'forStart) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'forSource) in
    Obj.repr(
# 198 "parser.mly"
                       ( ForBody(_1, _2) )
# 1118 "parser.ml"
               : 'forBody))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'forVar) in
    Obj.repr(
# 201 "parser.mly"
                ( ForStart(_2) )
# 1125 "parser.ml"
               : 'forStart))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 204 "parser.mly"
                    ( ForVar(_1) )
# 1132 "parser.ml"
               : 'forVar))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 207 "parser.mly"
                     ( ForSource(_2) )
# 1139 "parser.ml"
               : 'forSource))
(* Entry root *)
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
let root (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.root)
