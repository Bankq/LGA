type op = 
	  Plus | Minus | Times | Divide | Eq | Neq | Mod | And | Or | Less | Leq | Greater | Geq | Not

type a' dummy_line = 
		Dummy of a' 
		
type identifier = 
	  Id of string
	  
type objAssignable = 
	  Id of string
	| ThisProperty of identifier
	
type parenthetical = 
	  Parenthetical of dummy_line list
		
type value = 
	  Id of string
	| ThisProperty of identifier
	| Assignable of value * identifier
	| Num of string
	| String of string
	| Boolean of string
	| Parenthetical of line list
	
type assignable = 
	  Id of string
	| ThisProperty of identifier
	| Assignable of value * identifier
		
type assignObj = 
	  AssginObj of objAssignable * expression
	
type expression = 
	  Binop of expression * string * expression
	| Object of assignObj list
	| Neg of expression
	| Assign of assignable * expression
	| If of ifblock * line list
	| IfOnly of ifblock
	| While of whilesource * line list
	| For of identifier * array * line list
	| Id of string
	| ThisProperty of identifier
	| Num of string
	| String of string
	| Boolean of string
	| Value of parenthetical
	| Invocation of value * expression list
	| Code of paramList * line list
	
type statement = 
	  Return of expression
	| Literal of string
	
type line = 
	  Expression of expression
	| Statement of statement
	
type root = 
	  line list

type ifblock =
	  IfBlock of expression * line list
	| IfBlockseq of ifblock * expression * line list

type whilesource =
	  WhileSource of expression

type array = 
	  Array of expression list

type paramList = 
	  Param of paramVar
	| Param of paramVar * expression

type paramVar = 
	  Id of string
	| Array of expression list
	| Object of assignList
	| ThisProperty of identifier

type obj = 
	  Object of assignObj list






		

		





