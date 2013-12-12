open Parser

let dedent_count = fun len stack -> 
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
  match list with
  | h :: t -> 
     begin match h with
           | INDENT ->
              TERMINATOR :: (h :: (expand_token_list t))
           | DEDENT_COUNT(x) ->
              if x = 1 then
                DEDENT :: (expand_token_list t)
              else
                DEDENT :: (expand_token_list (DEDENT_COUNT(x-1) :: t))
           | _ ->
              h :: (expand_token_list t)
     end
  | [] -> []
  
let token_list_of_lexbuf lexbuf tokenizer stopsign =
  let rec helper lexbuf list = 
    let token = tokenizer lexbuf in 
    if token = stopsign then list
    else token :: (helper lexbuf list)
  in helper lexbuf []

let string_of_token : Parser.token -> string = function
  | ID(x) ->
     Printf.sprintf "ID<%s>" x
  | NUM(x) ->
     Printf.sprintf "NUM<%f>" x
  | ASSIGN ->
     "ASSIGN"
  | INDENT ->
     "INDENT"
  | DEDENT_COUNT(x) ->
     Printf.sprintf "DEDENT<%d>" x
  | DEDENT ->
     "DEDENT"
  | EOF ->
     "EOF"
  | _ ->
     "UNKNOWN"
