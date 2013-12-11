open Lexing
open Parser
open List
open Utils

let _ = 
  let lexbuf = Lexing.from_channel (open_in "test_scanner_in.lga") in 
  let token_list = token_list_of_lexbuf lexbuf Scanner.token Parser.EOF in
  let print x = print_endline (string_of_token x) in
  List.iter print token_list


