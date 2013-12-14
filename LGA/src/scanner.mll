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
		| '['				{ LBK }
		| ']'				{ RBK }
		| ','      			{ COMMA }
		| ':'      			{ COLON }
		| '='      			{ ASSIGN }
		| '+'				{ PLUS }
		| '-'				{ MINUS }
		| '*'				{ TIMES }
		| '/'				{ DIVIDE }
		| '%'				{ MOD }
		| '+'				{ PLUS }
		| '<'      			{ LT }
		| '>'      			{ GT }
		| '.'				{ DOT }
		| '!'				{ NOT }
        | "not"             { NOT }
		| "=="				{ EQ }
        | "is"              { EQ}
		| "!="				{ NEQ }
        | "isnt"            { NEQ }
		| "<="				{ LEQ }
		| ">="				{ GEQ }
        | "&&"              { AND }
		| "and"				{ AND }
        | "||"              { OR }
		| "or"				{ OR }
		| "->"     			{ ARROW }
		| "false" as lxm    { BOOL(lxm) }
		| "true" as lxm  	{ BOOL(lxm) }
		| "if"     			{ IF }
		| "else"   			{ ELSE }
		| "return" 			{ RETURN } 
		| "while"  			{ WHILE }
		| "for"  			{ FOR }
		| "in"				{ FORIN }
		| "break"			{ STATEMENT("break") }
		| "continue"		{ STATEMENT("continue") }
        | "fun"             { FUN }
		| id as lxm         { IDENTIFIER(lxm) }
		| num as lxm        { NUM(lxm) }
		| string as lxm		{ STRING(lxm) }
		| eof               { EOF }
		| _ as char         { raise (Failure("SCANNER: illegal input"^Char.escaped char)) }
					   
and indent = parse
		   | spacetab as s 
	   		{
			 let len = (String.length s) in
			 let top_pos = (Stack.top _indent_stack) in
			 if len > top_pos then
			   begin
				 Stack.push len _indent_stack;
				 INDENT
			   end
			 else if len = top_pos then TERMINATOR
			 else
			   let _count = (Utils.outdent_count len _indent_stack) in
			   if _count = -1 then raise (Failure("SCANNER: wrong indent"))
			   else OUTDENT_COUNT(_count)
			}

and comment = parse
				'\n' { token lexbuf }
			| _    { comment lexbuf }


{
  Stack.push 0 _indent_stack
}
