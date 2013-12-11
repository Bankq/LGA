{
	open Parser
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let id = ('_'|letter) (letter|digit|'_')*
let exp = 'e'('+'|'-')?['0'-'9']+
let num = digit+

rule token = parse
	[' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
	| '='      { ASSIGN }
	| id as lxm { ID(lxm) }
	| num as lxm { NUM(float_of_string lxm) }
	| eof { EOF }
	| _ as char { raise (Failure("Illegal character: " ^ Char.escaped char)) }

and comment = parse
	'\n' { token lexbuf }
	| _    { comment lexbuf }
