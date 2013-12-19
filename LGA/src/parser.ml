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
\011\000\016\000\016\000\010\000\010\000\008\000\008\000\008\000\
\012\000\012\000\012\000\018\000\018\000\018\000\018\000\018\000\
\018\000\026\000\026\000\027\000\027\000\025\000\025\000\022\000\
\022\000\029\000\029\000\029\000\029\000\009\000\030\000\030\000\
\031\000\031\000\031\000\031\000\031\000\017\000\017\000\017\000\
\017\000\017\000\028\000\032\000\020\000\020\000\021\000\021\000\
\003\000\003\000\023\000\019\000\019\000\019\000\019\000\024\000\
\013\000\013\000\033\000\033\000\014\000\034\000\015\000\035\000\
\036\000\038\000\037\000\000\000"

let yylen = "\002\000\
\000\000\001\000\002\000\001\000\003\000\002\000\001\000\001\000\
\001\000\001\000\002\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000\001\000\001\000\006\000\006\000\001\000\001\000\001\000\
\003\000\004\000\005\000\001\000\001\000\001\000\001\000\002\000\
\002\000\003\000\005\000\001\000\001\000\002\000\001\000\004\000\
\003\000\000\000\001\000\003\000\004\000\002\000\002\000\003\000\
\001\000\003\000\004\000\003\000\005\000\000\000\001\000\003\000\
\004\000\005\000\003\000\001\000\003\000\005\000\002\000\003\000\
\002\000\003\000\001\000\001\000\001\000\001\000\001\000\002\000\
\001\000\003\000\003\000\005\000\002\000\002\000\002\000\002\000\
\002\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\087\000\000\000\000\000\000\000\000\000\083\000\084\000\085\000\
\010\000\086\000\000\000\100\000\000\000\000\000\004\000\007\000\
\008\000\009\000\000\000\000\000\014\000\015\000\016\000\017\000\
\018\000\019\000\000\000\000\000\039\000\040\000\044\000\045\000\
\046\000\047\000\000\000\000\000\000\000\000\000\011\000\081\000\
\000\000\000\000\079\000\065\000\000\000\000\000\000\000\033\000\
\052\000\053\000\059\000\000\000\000\000\088\000\000\000\094\000\
\098\000\097\000\000\000\000\000\003\000\000\000\000\000\000\000\
\048\000\055\000\062\000\049\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\093\000\095\000\000\000\096\000\082\000\
\000\000\080\000\000\000\000\000\077\000\000\000\000\000\000\000\
\057\000\091\000\000\000\071\000\005\000\076\000\000\000\063\000\
\000\000\054\000\020\000\021\000\022\000\023\000\024\000\025\000\
\026\000\027\000\028\000\029\000\030\000\031\000\032\000\000\000\
\000\000\041\000\000\000\090\000\099\000\068\000\000\000\000\000\
\066\000\000\000\000\000\050\000\056\000\060\000\000\000\000\000\
\000\000\075\000\064\000\042\000\000\000\000\000\067\000\000\000\
\078\000\000\000\000\000\061\000\000\000\000\000\000\000\072\000\
\043\000\092\000\069\000\051\000\036\000\037\000\073\000\000\000\
\074\000"

let yydgoto = "\002\000\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\030\000\031\000\032\000\033\000\034\000\035\000\
\107\000\036\000\037\000\038\000\039\000\040\000\041\000\042\000\
\073\000\059\000\060\000\074\000\061\000\075\000\053\000\111\000\
\043\000\044\000\045\000\046\000\095\000\066\000"

let yysindex = "\033\000\
\191\255\000\000\061\001\211\255\149\000\092\000\061\001\045\255\
\000\000\249\254\061\001\061\001\249\254\000\000\000\000\000\000\
\000\000\000\000\034\255\000\000\043\255\053\255\000\000\000\000\
\000\000\000\000\024\255\025\255\000\000\000\000\000\000\000\000\
\000\000\000\000\109\255\059\255\000\000\000\000\000\000\000\000\
\000\000\000\000\038\255\077\255\077\255\073\255\000\000\000\000\
\144\255\223\000\000\000\000\000\018\255\112\000\102\255\000\000\
\000\000\000\000\000\000\086\255\020\255\000\000\077\255\000\000\
\000\000\000\000\249\254\112\000\000\000\075\255\186\000\249\254\
\000\000\000\000\000\000\000\000\061\001\061\001\061\001\061\001\
\061\001\061\001\061\001\061\001\061\001\061\001\061\001\061\001\
\061\001\035\255\004\255\000\000\000\000\061\001\000\000\000\000\
\007\255\000\000\154\255\157\255\000\000\004\001\111\255\045\255\
\000\000\000\000\047\255\000\000\000\000\000\000\110\255\000\000\
\052\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\061\001\
\061\001\000\000\061\001\000\000\000\000\000\000\061\001\223\000\
\000\000\123\255\061\001\000\000\000\000\000\000\112\255\128\255\
\003\255\000\000\000\000\000\000\130\255\077\255\000\000\013\255\
\000\000\135\255\045\255\000\000\041\001\249\254\249\254\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\022\255\
\000\000"

let yyrindex = "\000\000\
\145\000\000\000\000\000\000\000\000\000\000\000\000\000\021\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\160\000\000\000\000\000\000\000\
\000\000\000\000\029\000\056\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
\000\000\000\000\083\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\091\255\084\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\148\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\023\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\010\000\214\255\096\000\008\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\007\000\000\000\000\000\000\000\000\000\000\000\252\255\002\000\
\139\000\153\255\000\000\000\000\064\000\000\000\223\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yytablesize = 616
let yytable = "\142\000\
\038\000\092\000\093\000\057\000\158\000\062\000\159\000\004\000\
\065\000\058\000\047\000\134\000\052\000\049\000\056\000\055\000\
\097\000\163\000\063\000\064\000\106\000\103\000\058\000\104\000\
\058\000\098\000\169\000\070\000\012\000\014\000\070\000\070\000\
\071\000\001\000\099\000\131\000\128\000\113\000\129\000\014\000\
\099\000\005\000\067\000\006\000\068\000\099\000\105\000\058\000\
\132\000\145\000\070\000\142\000\072\000\072\000\069\000\013\000\
\144\000\052\000\007\000\090\000\008\000\147\000\108\000\100\000\
\009\000\010\000\011\000\114\000\012\000\013\000\091\000\014\000\
\015\000\016\000\145\000\010\000\018\000\019\000\052\000\099\000\
\004\000\014\000\089\000\006\000\115\000\116\000\117\000\118\000\
\119\000\120\000\121\000\122\000\123\000\124\000\125\000\126\000\
\127\000\130\000\057\000\057\000\070\000\133\000\152\000\068\000\
\058\000\058\000\137\000\162\000\094\000\140\000\102\000\101\000\
\110\000\155\000\165\000\104\000\156\000\146\000\070\000\077\000\
\078\000\079\000\080\000\081\000\082\000\083\000\084\000\085\000\
\086\000\087\000\088\000\089\000\153\000\157\000\161\000\148\000\
\149\000\141\000\150\000\164\000\160\000\010\000\151\000\052\000\
\001\000\068\000\154\000\014\000\096\000\058\000\057\000\058\000\
\058\000\167\000\108\000\135\000\058\000\136\000\068\000\002\000\
\005\000\138\000\006\000\109\000\166\000\168\000\076\000\143\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\007\000\000\000\008\000\000\000\000\000\000\000\009\000\
\010\000\011\000\000\000\012\000\013\000\000\000\014\000\015\000\
\016\000\003\000\004\000\018\000\019\000\005\000\000\000\006\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\003\000\007\000\048\000\
\008\000\005\000\000\000\006\000\009\000\010\000\011\000\000\000\
\012\000\013\000\000\000\014\000\015\000\016\000\017\000\000\000\
\018\000\019\000\007\000\000\000\008\000\000\000\000\000\000\000\
\009\000\010\000\011\000\000\000\012\000\013\000\000\000\014\000\
\015\000\016\000\017\000\000\000\018\000\019\000\000\000\000\000\
\000\000\000\000\038\000\000\000\038\000\038\000\000\000\038\000\
\038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
\038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
\000\000\000\000\000\000\038\000\038\000\038\000\012\000\000\000\
\012\000\012\000\000\000\000\000\012\000\000\000\012\000\034\000\
\034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
\034\000\034\000\034\000\034\000\000\000\000\000\000\000\012\000\
\012\000\013\000\000\000\013\000\013\000\000\000\000\000\013\000\
\000\000\013\000\035\000\035\000\035\000\035\000\035\000\035\000\
\035\000\035\000\035\000\035\000\035\000\035\000\035\000\000\000\
\000\000\000\000\013\000\013\000\089\000\006\000\089\000\089\000\
\006\000\000\000\089\000\000\000\089\000\006\000\003\000\054\000\
\000\000\000\000\005\000\000\000\006\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\089\000\089\000\000\000\
\000\000\000\000\003\000\007\000\000\000\008\000\005\000\000\000\
\006\000\009\000\010\000\011\000\000\000\012\000\013\000\000\000\
\014\000\015\000\016\000\017\000\000\000\018\000\019\000\007\000\
\000\000\008\000\000\000\000\000\000\000\009\000\010\000\011\000\
\000\000\012\000\013\000\000\000\014\000\015\000\016\000\017\000\
\050\000\018\000\019\000\005\000\051\000\006\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\007\000\000\000\008\000\000\000\
\000\000\000\000\009\000\010\000\011\000\000\000\012\000\013\000\
\000\000\014\000\015\000\016\000\000\000\050\000\018\000\019\000\
\005\000\000\000\006\000\112\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\007\000\000\000\008\000\000\000\000\000\000\000\009\000\
\010\000\011\000\000\000\012\000\013\000\000\000\014\000\015\000\
\016\000\000\000\050\000\018\000\019\000\005\000\000\000\006\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\007\000\000\000\
\008\000\000\000\000\000\000\000\009\000\010\000\011\000\000\000\
\012\000\013\000\000\000\014\000\015\000\016\000\000\000\139\000\
\018\000\019\000\005\000\000\000\006\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\007\000\000\000\008\000\000\000\000\000\
\000\000\009\000\010\000\011\000\000\000\012\000\013\000\000\000\
\014\000\015\000\016\000\000\000\004\000\018\000\019\000\005\000\
\000\000\006\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\007\000\000\000\008\000\005\000\000\000\006\000\009\000\010\000\
\011\000\000\000\012\000\013\000\000\000\014\000\015\000\016\000\
\000\000\000\000\018\000\019\000\007\000\000\000\008\000\000\000\
\000\000\000\000\009\000\010\000\011\000\000\000\012\000\013\000\
\000\000\014\000\015\000\016\000\000\000\000\000\018\000\019\000"

let yycheck = "\103\000\
\000\000\044\000\045\000\008\000\002\001\010\000\004\001\004\001\
\013\000\008\000\003\000\005\001\005\000\004\000\007\000\006\000\
\050\000\005\001\011\000\012\000\063\000\002\001\002\001\004\001\
\004\001\008\001\005\001\005\001\000\000\037\001\007\001\007\001\
\009\001\001\000\028\001\032\001\002\001\071\000\004\001\037\001\
\028\001\007\001\009\001\009\001\002\001\028\001\027\001\027\001\
\091\000\028\001\028\001\155\000\029\001\029\001\002\001\000\000\
\010\001\050\000\024\001\001\001\026\001\010\001\067\000\054\000\
\030\001\031\001\032\001\072\000\034\001\035\001\033\001\037\001\
\038\001\039\001\028\001\031\001\042\001\043\001\071\000\028\001\
\004\001\037\001\000\000\000\000\077\000\078\000\079\000\080\000\
\081\000\082\000\083\000\084\000\085\000\086\000\087\000\088\000\
\089\000\090\000\103\000\104\000\010\001\094\000\136\000\002\001\
\103\000\104\000\099\000\150\000\036\001\102\000\025\001\010\001\
\038\001\002\001\157\000\004\001\005\001\008\001\028\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\021\001\022\001\023\001\010\001\006\001\005\001\128\000\
\129\000\027\001\131\000\005\001\145\000\031\001\135\000\136\000\
\000\000\002\001\139\000\037\001\005\001\002\001\155\000\004\001\
\005\001\158\000\159\000\002\001\155\000\004\001\002\001\000\000\
\007\001\005\001\009\001\068\000\157\000\159\000\028\000\104\000\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\024\001\255\255\026\001\255\255\255\255\255\255\030\001\
\031\001\032\001\255\255\034\001\035\001\255\255\037\001\038\001\
\039\001\003\001\004\001\042\001\043\001\007\001\255\255\009\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\003\001\024\001\005\001\
\026\001\007\001\255\255\009\001\030\001\031\001\032\001\255\255\
\034\001\035\001\255\255\037\001\038\001\039\001\040\001\255\255\
\042\001\043\001\024\001\255\255\026\001\255\255\255\255\255\255\
\030\001\031\001\032\001\255\255\034\001\035\001\255\255\037\001\
\038\001\039\001\040\001\255\255\042\001\043\001\255\255\255\255\
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
\255\255\255\255\003\001\024\001\255\255\026\001\007\001\255\255\
\009\001\030\001\031\001\032\001\255\255\034\001\035\001\255\255\
\037\001\038\001\039\001\040\001\255\255\042\001\043\001\024\001\
\255\255\026\001\255\255\255\255\255\255\030\001\031\001\032\001\
\255\255\034\001\035\001\255\255\037\001\038\001\039\001\040\001\
\004\001\042\001\043\001\007\001\008\001\009\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\024\001\255\255\026\001\255\255\
\255\255\255\255\030\001\031\001\032\001\255\255\034\001\035\001\
\255\255\037\001\038\001\039\001\255\255\004\001\042\001\043\001\
\007\001\255\255\009\001\010\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\024\001\255\255\026\001\255\255\255\255\255\255\030\001\
\031\001\032\001\255\255\034\001\035\001\255\255\037\001\038\001\
\039\001\255\255\004\001\042\001\043\001\007\001\255\255\009\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\024\001\255\255\
\026\001\255\255\255\255\255\255\030\001\031\001\032\001\255\255\
\034\001\035\001\255\255\037\001\038\001\039\001\255\255\004\001\
\042\001\043\001\007\001\255\255\009\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\024\001\255\255\026\001\255\255\255\255\
\255\255\030\001\031\001\032\001\255\255\034\001\035\001\255\255\
\037\001\038\001\039\001\255\255\004\001\042\001\043\001\007\001\
\255\255\009\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\024\001\255\255\026\001\007\001\255\255\009\001\030\001\031\001\
\032\001\255\255\034\001\035\001\255\255\037\001\038\001\039\001\
\255\255\255\255\042\001\043\001\024\001\255\255\026\001\255\255\
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
# 434 "parser.ml"
               : Ast.root))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 36 "parser.mly"
        ( _1 )
# 441 "parser.ml"
               : Ast.root))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'block) in
    Obj.repr(
# 37 "parser.mly"
                    ( _1 )
# 448 "parser.ml"
               : Ast.root))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'line) in
    Obj.repr(
# 40 "parser.mly"
        ( [_1] )
# 455 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'body) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'line) in
    Obj.repr(
# 41 "parser.mly"
                        ( List.append _1 [_3] )
# 463 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'body) in
    Obj.repr(
# 42 "parser.mly"
                   ( _1 )
# 470 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 45 "parser.mly"
              ( ExpressionLine(_1) )
# 477 "parser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'statement) in
    Obj.repr(
# 46 "parser.mly"
             ( StatementLine(_1) )
# 484 "parser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'return) in
    Obj.repr(
# 49 "parser.mly"
          ( ReturnStatement(_1) )
# 491 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "parser.mly"
             ( LiteralStatement(Literal(_1)) )
# 498 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 53 "parser.mly"
                     ( Return(_2) )
# 505 "parser.ml"
               : 'return))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 56 "parser.mly"
         ( ValueExpression(_1) )
# 512 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'invocation) in
    Obj.repr(
# 57 "parser.mly"
              ( InvocationExpression(_1) )
# 519 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'code) in
    Obj.repr(
# 58 "parser.mly"
        ( CodeExpression(_1) )
# 526 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'operation) in
    Obj.repr(
# 59 "parser.mly"
             ( OperationExpression(_1) )
# 533 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assign) in
    Obj.repr(
# 60 "parser.mly"
          ( AssignExpression(_1) )
# 540 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'iftype) in
    Obj.repr(
# 61 "parser.mly"
          ( IfExpression(_1) )
# 547 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'whiletype) in
    Obj.repr(
# 62 "parser.mly"
             ( WhileExpression(_1) )
# 554 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'fortype) in
    Obj.repr(
# 63 "parser.mly"
           ( ForExpression(_1) )
# 561 "parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 66 "parser.mly"
                        ( Binop(_1, Plus,_3) )
# 569 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 67 "parser.mly"
                         ( Binop(_1, Minus, _3) )
# 577 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 68 "parser.mly"
                         ( Binop(_1, Times, _3) )
# 585 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 69 "parser.mly"
                          ( Binop(_1, Divide, _3))
# 593 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 70 "parser.mly"
                      ( Binop(_1, Eq, _3) )
# 601 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 71 "parser.mly"
                       ( Binop(_1, Neq, _3) )
# 609 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 72 "parser.mly"
                       ( Binop(_1, Mod, _3) )
# 617 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 73 "parser.mly"
                       ( Binop(_1, And, _3) )
# 625 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 74 "parser.mly"
                          ( Binop(_1, Or, _3) )
# 633 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 75 "parser.mly"
                          ( Binop(_1, Less, _3) )
# 641 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 76 "parser.mly"
                       ( Binop(_1, Leq, _3) )
# 649 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 77 "parser.mly"
                          ( Binop(_1, Greater, _3) )
# 657 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'lop) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 78 "parser.mly"
                       ( Binop(_1, Geq, _3) )
# 665 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 79 "parser.mly"
                    ( Neg(_2) )
# 672 "parser.ml"
               : 'operation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 82 "parser.mly"
         ( ValueLop(_1) )
# 679 "parser.ml"
               : 'lop))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'invocation) in
    Obj.repr(
# 83 "parser.mly"
              ( InvocationLop(_1) )
# 686 "parser.ml"
               : 'lop))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'paramList) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 86 "parser.mly"
                                           ( BlockCode(_3, _6) )
# 694 "parser.ml"
               : 'code))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'paramList) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 87 "parser.mly"
                                                   ( ExpressionCode(_3, _6) )
# 702 "parser.ml"
               : 'code))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assignable) in
    Obj.repr(
# 90 "parser.mly"
                 ( AssignableValue(_1) )
# 709 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 91 "parser.mly"
           ( LiteralValue(_1) )
# 716 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'parenthetical) in
    Obj.repr(
# 92 "parser.mly"
                 ( ParentheticalValue(_1) )
# 723 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'assignable) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 95 "parser.mly"
                                               ( Assign (_1, _3) )
# 731 "parser.ml"
               : 'assign))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'assignable) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 96 "parser.mly"
                                               ( Assign (_1, _4) )
# 739 "parser.ml"
               : 'assign))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'assignable) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 97 "parser.mly"
                                               ( Assign (_1, _4) )
# 747 "parser.ml"
               : 'assign))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'array) in
    Obj.repr(
# 100 "parser.mly"
         ( ArrayAssignable(_1) )
# 754 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'obj) in
    Obj.repr(
# 101 "parser.mly"
       ( ObjAssignable(_1) )
# 761 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 102 "parser.mly"
              ( IdentifierAssignable(_1) )
# 768 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'thisProperty) in
    Obj.repr(
# 103 "parser.mly"
                ( ThisPropertyAssignable(_1) )
# 775 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'value) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'accessor) in
    Obj.repr(
# 104 "parser.mly"
                  ( ValueAccessorAssignable(_1, _2) )
# 783 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'invocation) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'accessor) in
    Obj.repr(
# 105 "parser.mly"
                       ( InvocationAccessorAssignable(_1, _2) )
# 791 "parser.ml"
               : 'assignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'objAssignable) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 108 "parser.mly"
                                  ( AssignObj(_1, _3) )
# 799 "parser.ml"
               : 'assignObj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'objAssignable) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 109 "parser.mly"
                                                 ( AssignObj(_1, _4) )
# 807 "parser.ml"
               : 'assignObj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 112 "parser.mly"
              ( IdentifierObjAssignable(_1))
# 814 "parser.ml"
               : 'objAssignable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'thisProperty) in
    Obj.repr(
# 113 "parser.mly"
                ( ThisPropertyObjAssignable(_1) )
# 821 "parser.ml"
               : 'objAssignable))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 116 "parser.mly"
                  ( DotAccessor(_2) )
# 828 "parser.ml"
               : 'accessor))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'index) in
    Obj.repr(
# 117 "parser.mly"
         ( IndexAccessor(_1) )
# 835 "parser.ml"
               : 'accessor))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'assignList) in
    Obj.repr(
# 120 "parser.mly"
                                          ( Object(_2) )
# 842 "parser.ml"
               : 'obj))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'assignList) in
    Obj.repr(
# 121 "parser.mly"
                               ( Object(_2) )
# 849 "parser.ml"
               : 'obj))
; (fun __caml_parser_env ->
    Obj.repr(
# 124 "parser.mly"
                 ( [] )
# 855 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assignObj) in
    Obj.repr(
# 125 "parser.mly"
             ( [_1] )
# 862 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'assignList) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'assignObj) in
    Obj.repr(
# 126 "parser.mly"
                                   ( List.append _1 [_3] )
# 870 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'assignList) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'assignList) in
    Obj.repr(
# 128 "parser.mly"
                                        ( List.append _1 _3 )
# 878 "parser.ml"
               : 'assignList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'value) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'arguments) in
    Obj.repr(
# 131 "parser.mly"
                   ( Invocation(_1, _2) )
# 886 "parser.ml"
               : 'invocation))
; (fun __caml_parser_env ->
    Obj.repr(
# 134 "parser.mly"
                 ( [] )
# 892 "parser.ml"
               : 'arguments))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 135 "parser.mly"
                         ( _2 )
# 899 "parser.ml"
               : 'arguments))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 138 "parser.mly"
              ( [_1] )
# 906 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'argList) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 139 "parser.mly"
                            ( List.append _1 [_3] )
# 914 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'argList) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 140 "parser.mly"
                                       ( List.append _1 [_4] )
# 922 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 141 "parser.mly"
                          ( _2 )
# 929 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'argList) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 142 "parser.mly"
                                        ( List.append _1 _4 )
# 937 "parser.ml"
               : 'argList))
; (fun __caml_parser_env ->
    Obj.repr(
# 145 "parser.mly"
                  ( [] )
# 943 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 146 "parser.mly"
              ( [_1] )
# 950 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'paramList) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 147 "parser.mly"
                              ( List.append _1 [_3] )
# 958 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'paramList) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 148 "parser.mly"
                                         ( List.append _1 [_4] )
# 966 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'paramList) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'paramList) in
    Obj.repr(
# 149 "parser.mly"
                                            (List.append _1 _4 )
# 974 "parser.ml"
               : 'paramList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'indexValue) in
    Obj.repr(
# 152 "parser.mly"
                      ( Index(_2) )
# 981 "parser.ml"
               : 'index))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 155 "parser.mly"
       ( Literal(_1) )
# 988 "parser.ml"
               : 'indexValue))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'body) in
    Obj.repr(
# 158 "parser.mly"
                      ( Parenthetical(_2) )
# 995 "parser.ml"
               : 'parenthetical))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'body) in
    Obj.repr(
# 159 "parser.mly"
                                     ( Parenthetical(_3) )
# 1002 "parser.ml"
               : 'parenthetical))
; (fun __caml_parser_env ->
    Obj.repr(
# 162 "parser.mly"
              ( [] )
# 1008 "parser.ml"
               : 'array))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'argList) in
    Obj.repr(
# 163 "parser.mly"
                      ( _2 )
# 1015 "parser.ml"
               : 'array))
; (fun __caml_parser_env ->
    Obj.repr(
# 166 "parser.mly"
                  ([])
# 1021 "parser.ml"
               : 'block))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'body) in
    Obj.repr(
# 167 "parser.mly"
                       ( _2 )
# 1028 "parser.ml"
               : 'block))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 170 "parser.mly"
              ( Literal(_1) )
# 1035 "parser.ml"
               : 'identifier))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 173 "parser.mly"
        ( Literal(_1) )
# 1042 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 174 "parser.mly"
          ( Literal(_1) )
# 1049 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 175 "parser.mly"
         ( Literal(_1) )
# 1056 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 176 "parser.mly"
         ( Literal(_1) )
# 1063 "parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 179 "parser.mly"
                      ( _2)
# 1070 "parser.ml"
               : 'thisProperty))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ifBlock) in
    Obj.repr(
# 182 "parser.mly"
                    ( IfOnly(_1) )
# 1077 "parser.ml"
               : 'iftype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'ifBlock) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 183 "parser.mly"
                      ( IfElse(_1, _3) )
# 1085 "parser.ml"
               : 'iftype))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 186 "parser.mly"
                             ( IfBlock(_2, _3) )
# 1093 "parser.ml"
               : 'ifBlock))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'ifBlock) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 187 "parser.mly"
                                    ( IfBlockSeq(_1, _4, _5) )
# 1102 "parser.ml"
               : 'ifBlock))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'whileSource) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 190 "parser.mly"
                      ( While(_1, _2) )
# 1110 "parser.ml"
               : 'whiletype))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 193 "parser.mly"
                     ( WhileSource(_2) )
# 1117 "parser.ml"
               : 'whileSource))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'forBody) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'block) in
    Obj.repr(
# 196 "parser.mly"
                   ( For(_1, _2) )
# 1125 "parser.ml"
               : 'fortype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'forStart) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'forSource) in
    Obj.repr(
# 199 "parser.mly"
                       ( ForBody(_1, _2) )
# 1133 "parser.ml"
               : 'forBody))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'forVar) in
    Obj.repr(
# 202 "parser.mly"
                ( ForStart(_2) )
# 1140 "parser.ml"
               : 'forStart))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'identifier) in
    Obj.repr(
# 205 "parser.mly"
                    ( ForVar(_1) )
# 1147 "parser.ml"
               : 'forVar))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 208 "parser.mly"
                     ( ForSource(_2) )
# 1154 "parser.ml"
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
