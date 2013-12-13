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
     Printf.sprintf "NUM<%f>" x
  | ASSIGN ->
     "ASSIGN"
  | INDENT ->
     "INDENT"
  | OUTDENT_COUNT(x) ->
     Printf.sprintf "OUTDENT<%d>" x
  | OUTDENT ->
     "OUTDENT"
  | TERMINATOR ->
     "TERMINATOR"
  | EOF ->
     "EOF"
  | _ ->
     "UNKNOWN"
