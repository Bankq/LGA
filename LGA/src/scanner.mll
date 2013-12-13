{
  open Parser
  open Utils
  let _indent_stack = Stack.create()
}

let punc = ['~' '`' '!' '@' '#' '$' '%' '^' '&' '*' '(' ')' '-' '+' '=' ',' '.' '?' '/' '<' '>' ':' '''  ';' '{' '}' '[' ']' '|' ' ']
let spacetab = [' ' '\t']*
let newline = ['\r' '\n']+
let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let id = ('_'|letter) (letter|digit|'_')*
let exp = 'e'('+'|'-')?['0'-'9']+
let num = '-'? (digit)+ ('.'? (digit)* exp?|exp)
let string = '"' (letter|digit|punc)*  '"'

rule token = parse
		| newline			{ indent lexbuf }
		| [' ' '\t']        { token lexbuf }
		| '#'               { comment lexbuf }
		| '@'               { THIS }
		| '='               { ASSIGN }
		| '('               { LPAREN }
		| ')'      			{ RPAREN }
		| '{'     			{ LBRACE }
		| '}'      			{ RBRACE }
		| '['				{ LBRACKET }
		| ']'				{ LBRACKET }
		| ';'      			{ SEMI }
		| ','      			{ COMMA }
		| ':'      			{ COLON }
		| '='      			{ ASSIGN }
		| '<'      			{ LT }
		| '>'      			{ GT }
		| '.'				{ DOT }
		| "->"     			{ ARROW }
		| "false"  			{ BOOL(false) }
		| "true"   			{ BOOL(true) }
		| "if"     			{ IF }
		| "else"   			{ ELSE }
		| "return" 			{ RETURN } 
		| "while"  			{ WHILE }
		| "for"  			{ FOR }
		| id as lxm         { ID(lxm) }
		| num as lxm        { NUM(float_of_string lxm) }
		| string as lxm	{ STRING(lxm) }
		| eof               { EOF }
		| _ as char         { raise (Failure("SCANNER: illegal input"^Char.escaped char)) }
					   
and indent = parse
		   | spacetab as s 
	   		{
			 let len = (String.length s) in
			 let top_pos = (Stack.top _stack) in
			 if len > top_pos then
			   begin
				 Stack.push len _stack;
				 INDENT
			   end
			 else if len = top_pos then token lexbuf
			 else
			   let _count = (Utils.dedent_count len _stack) in
			   if _count = -1 then raise (Failure("SCANNER: wrong indent"))
			   else DEDENT_COUNT(_count)
			}
and comment = parse
				'\n' { token lexbuf }
			| _    { comment lexbuf }


{
  Stack.push 0 _indent_stack
}
