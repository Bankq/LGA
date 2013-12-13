open Lexing
open Parser
open List
open Utils

let string_list_of_input_file file = 
  let lexbuf = Lexing.from_channel (open_in file) in 
  let raw_token_list = token_list_of_lexbuf lexbuf Scanner.token Parser.EOF in
  let token_list = expand_token_list raw_token_list in
  let stringify x = Printf.sprintf "%s " (string_of_token x) in
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

let test_file infile outfile =
  let in_list = (string_list_of_input_file infile) in
  let out_list = (string_list_of_output_file outfile) in
  let equal = fun x -> (fst x) = (snd x) in
  List.for_all equal (List.combine in_list out_list)

let _ = 
  let indir = Sys.argv.(1) in
  let outdir = Sys.argv.(2) in
  let infile_array = Sys.readdir indir in
  let test file =
    test_file (String.concat "" [indir;file]) (String.concat "" ([outdir;file;".out"])) 
  in
  let result = Array.map test infile_array in
  let is_true x = x in
  let print r = 
    if (snd r) then Printf.printf "%s Pass" (fst r)
    else Printf.printf "%s Fail" (fst r) in
  let infile_list = Array.to_list infile_array in
  let result_list = Array.to_list result in
  List.map print (List.combine infile_list result_list);
  print_endline "";
  if List.for_all is_true result_list then
    print_endline "All Pass!"
  else print_endline "Fail!"
           

                       
