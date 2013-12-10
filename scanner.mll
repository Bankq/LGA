let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
(* let punc = ['~' '!' '@' '#' '$' '%' '^' '&' '*' '(' ')' '-' '+' '=' ',' '.' '?' '/' '<' '>' ':' '''  ';' '{' '}' '[' ']' '|' ' ']
*)
let id = ('_'|letter) (letter|digit|'_')*
let exp = 'e'('+'|'-')?['0'-'9']+
let num = '-'? (digit)+ ('.'? (digit)* exp?|exp)

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| '#'     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| ';'      { SEMI }
| ','      { COMMA }
| ':'      { COLON }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| '='      { ASSIGN }
| "&&"     { AND }
| "||"     { OR }
| '^'      { POW }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "->"     { ARROW }
| "boolean" { BOOLEAN }
| "compute" { COMPUTE }
| "double" { DOUBLE }
| "false"  { FALSE }
| "true"   { TRUE }
| "if"     { IF }
| "else"   { ELSE }
| "int"    { INT } 
| "return" { RETURN } 
| "rules"  { RULES }
| "string" { STRING }
| "while"  { WHILE }
| id as lxm { ID(lxm) }
| num as lxm { LITERAL(float_of_string lxm) }
| eof { EOF }
| _ as char { raise (Failure("Illegal character: " ^ Char.escaped char)) }

and comment = parse
  '\n' { token lexbuf }
| _    { comment lexbuf }
