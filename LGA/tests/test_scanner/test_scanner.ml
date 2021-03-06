open Lexing
open Parser
open List
open Utils

let string_list_of_input_file file = 
  let lexbuf = Lexing.from_channel (open_in file) in 
  let token_list = token_list_of_lexbuf lexbuf Scanner.token Parser.EOF in
  let stringify x = Printf.sprintf "%s" (string_of_token x) in
  List.map stringify token_list

let string_list_of_output_file file =
  let lines = ref [] in
  let ic = open_in file in
  try
    while true; do
      lines := input_line ic :: !lines
    done; []
  with End_of_file ->
    close_in ic;
    List.rev !lines

(* Compare the tokens list generated by input file, with the expected output (outfile) *)
let test_file infile outfile =
  let in_list = (string_list_of_input_file infile) in
  let out_list = (string_list_of_output_file outfile) in
  let equal = fun x -> (fst x) = (snd x) in
  if List.length in_list = List.length out_list then
  List.for_all equal (List.combine in_list out_list)
  else (print_endline "Token list length doesn't match."; false)
  
let _ = 
  print_endline "\n*** SCANNER TEST ***\n";
  let indir = Sys.argv.(1) in
  let outdir = Sys.argv.(2) in
  test_dir test_file indir outdir

                       
