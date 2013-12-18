open Printf
open Ast
open Scanner
open Parser
open Utils
open Codegen_handler


let print_result filename = 
	let rs = get_code_str filename in
		print_endline rs

let _ = 
	let filename = Sys.argv.(1) in
		print_result filename
