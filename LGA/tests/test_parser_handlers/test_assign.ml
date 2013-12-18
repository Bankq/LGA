open Printf
open Ast
open Scanner
open Parser
open Utils
open Semantic

let string_list_of_file file = 
	let lines = ref [] in
	let ic = open_in file in
	try
	 while true; do
	   lines := input_line ic :: !lines
	 done; []
	with End_of_file ->
	 close_in ic;
	 List.rev !lines
(*
let string_list_of_input_file file =
	let 
*)

let test_file ast expc = 
	let equal = fun x -> (fst x) = (snd x) in
	if List.for_all equal (List.combine ast expc) then true
	else false

let file_filter = fun dir ->
	let infile_array = Sys.readdir dir in
	let raw_file_list = Array.to_list infile_array in
	let is_target = fun file ->
	   if (String.sub file 0 4) = "test" then true else false in
	List.filter is_target raw_file_list

let print_result = fun ast expc infile->
	if(test_file ast expc) then Printf.sprintf "Test %s PASS!" infile
	else Printf.sprintf "Test %s FAIL!" infile

let test_dir indir outdir = 
	let in_files = (file_filter indir) in
	let test_file_fun = fun infile in_dir ->
		let ast = string_list_of_file (abs_input_testfile indir infile) and
 		    expc = string_list_of_file (abs_output_testfile_of_input outdir infile) in 
	print_result ast expc infile
	in
	List.map test_file_fun in_files



let _ =
	let indir = Sys.argv.(1) in
	let outdir = Sys.argv.(1) in
	test_dir indir outdir
