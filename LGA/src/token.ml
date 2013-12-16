open Lexing
open Parser
open List
open Utils

let string_list_of_input_file file = 
  let lexbuf = Lexing.from_channel (open_in file) in 
  let token_list = token_list_of_lexbuf lexbuf Scanner.token Parser.EOF in
  let stringify x = Printf.sprintf "%s" (string_of_token x) in
  List.map stringify token_list

let _ = 
  let filename = Sys.argv.(1) in
  let l = string_list_of_input_file filename in
  List.iter print_endline l
