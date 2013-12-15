open Ast
open Scanner
open Parser
open Utils

let check_literal = function
	Literal(x) -> x
	| _ -> "FAILURE, not literal"

let check_fst = function
	IdentifierAssignable(x) -> check_literal x
	| _ -> "FAILURE, not identifier"

let check_literal_value = function
	LiteralValue(x) -> check_literal x
	| _ -> "FAILURE, not literal value"

let check_snd = function
	ValueExpression(x) -> check_literal_value x
	| _ -> "FAILURE, not value expression"

let check_assign = function
	Assign(e1, e2) -> 
		(*let x = check_fst e1 and y = check_snd e2 in [e1; e2]*)
		let x = check_fst e1 in [x]
	| _ -> ["FAILURE, not assign"]
	

let check_assign_expression = function
	AssignExpression(x) -> check_assign x
	| _ -> [""]

let r = []

let check_expression_line ast = 
	match ast with
	| ExpressionLine(x) -> check_assign_expression x
	| _ -> ["FAILURE, not expression line"]



let handle_assgin = fun ast
	-> let rs = List.iter check_expression_line ast in
		 List.append r rs; print

let _ =
	let infile = Sys.argv.(1) in
	let ast = ast_of_file Parser.root Scanner.token infile
	in handle_assign ast
	 
	

