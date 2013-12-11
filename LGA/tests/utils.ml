open Parser

let token_list_of_lexbuf lexbuf tokenizer stopsign =
  let rec helper lexbuf list = 
    let token = tokenizer lexbuf in 
    if token == stopsign then list
    else token :: (helper lexbuf list)
  in
  helper lexbuf []

let string_of_token : Parser.token -> string = function
  | ID(x) ->
     Printf.sprintf "ID<%s>" x
  | NUM(x) ->
     Printf.sprintf "NUM<%f>" x
  | ASSIGN ->
     "ASSIGN"
  | EOF ->
     "EOF"
  | _ ->
     "UNKNOWN"
