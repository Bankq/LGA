open Lexing
open Parser
open List


let rec token_list_of_lexbuf lexbuf list =
  let token = Scanner.token lexbuf in 
    match token with
    | EOF ->
       list
    | _ ->
       token :: (token_list_of_lexbuf lexbuf list)

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


let _ = 
  let lexbuf = Lexing.from_channel (open_in "test_scanner_in.lga") in 
  let token_list = token_list_of_lexbuf lexbuf [] in
  let print x = print_endline (string_of_token x) in
  List.iter print token_list


