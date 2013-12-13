type op = 
	  Plus | Minus | Times | Divide | Eq | Neq | Mod | And | Or | Less | Leq | Greater | Geq | Not

type root = 
	  line list

type line = 
		Expression of expression
	| Statement of statement

type statement = 
		Return of expression
	| Comment of string
	| Literal of string

type expression = 
	  Binop of expression * string * expression
	| Neg of expression
	| Assign of assignable * expression
		
	    





