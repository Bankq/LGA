open Parser

let outdent_count = fun len stack -> 
  let rec helper inc = 
    if (Stack.top stack) > len then
      begin 
        Stack.pop stack;
        helper (inc + 1)
      end
    else if (Stack.top stack) < len then -1
    else inc
  in helper 0

let rec expand_token_list = fun list ->
  let rec expand_token = fun token ->
    match token with
    | INDENT -> TERMINATOR :: [token]
    | OUTDENT_COUNT(x) ->
       let rec populate token =
         match token with
         | OUTDENT_COUNT(x) ->
            if x = 1 then [OUTDENT]
            else OUTDENT :: (populate (OUTDENT_COUNT(x-1)))
         | _ -> [token] in
       TERMINATOR :: (populate token)
    | _ -> [token] in
  List.flatten (List.map expand_token list)

  
let token_list_of_lexbuf lexbuf tokenizer stopsign =
  let rec helper lexbuf list = 
    let token = tokenizer lexbuf in 
    if token = stopsign then list
    else token :: (helper lexbuf list)
  in helper lexbuf []

let string_of_token : Parser.token -> string = function
  | IDENTIFIER(x) ->
     Printf.sprintf "IDENTIFIER<%s>" x
  | NUM(x) ->
     Printf.sprintf "NUM<%s>" x
  | STATEMENT(x) ->
     Printf.sprintf "STATEMENT<%s>" x
  | BOOL(x) ->
     Printf.sprintf "BOOL<%s>" x
  | ASSIGN ->
     "ASSIGN"
  | TERMINATOR ->
     "TERMINATOR"
  | RETURN ->
     "RETURN"
  | ARROW ->
     "ARROW"
  | LBK ->
     "LBK"
  | RBK ->
     "RBK"
  | LPAREN ->
     "LPAREN"
  | RPAREN ->
     "RPAREN"
  | LBRACE ->
     "LBRACE"
  | RBRACE ->
     "RBRACE"
  | PLUS ->
     "PLUS"
  | MINUS ->
     "MINUS"
  | TIMES ->
     "TIMES"
  | DIVIDE ->
     "DIVIDE"
  | EQ ->
     "EQ"
  | NEQ ->
     "NEQ"
  | MOD ->
     "MOD"
  | AND ->
     "AND"
  | OR ->
     "OR"
  | LT ->
     "LT"
  | LEQ ->
     "LEQ"
  | GT ->
     "GT"
  | GEQ ->
     "GEQ"
  | NOT ->
     "NOT"
  | COLON ->
     "COLON"
  | COMMA ->
     "COMMA"
  | DOT ->
     "DOT"
  | NULL ->
     "NULL"
  | THIS ->
     "THIS"
  | IF ->
     "IF"
  | ELSE ->
     "ELSE"
  | WHILE ->
     "WHILE"
  | FOR ->
     "FOR"
  | FORIN ->
     "FORIN"
  | INDENT ->
     "INDENT"
  | OUTDENT_COUNT(x) ->
     Printf.sprintf "OUTDENT<%d>" x
  | OUTDENT ->
     "OUTDENT"
  | EOF ->
     "EOF"
  | _ ->
     "UNKNOWN"
