type op = 
	  Plus | Minus | Times | Divide | Eq | Neq | Mod | And | Or | Less | Leq | Greater | Geq | Not

type identifier = 
	  Id of string
	  
type objAssignable = 
	  Id of string
	| ThisProperty of identifier

type value = 
	  Id of string
	| ThisProperty of identifier
	| Assignable of value * identifier
	| Num of string
	| String of string
	| Boolean of bool
	
type assignable = 
	  Id of string
	| ThisProperty of identifier
	| Assignable of value * identifier
	
type expression = 
	  Binop of expression * op * expression
	| Object of (objAssignable * expression) list
	| Neg of expression
	| Assign of assignable * expression	
	| Id of string
	| ThisProperty of identifier
	| Num of string
	| String of string
	| Boolean of string
	| Invocation of value * expression list

type whilesource =
	  WhileSource of expression

type array = 
	  Array of expression list

type paramVar = 
	  Id of string
	| Array of expression list
	| Object of (objAssignable * expression) list
	| ThisProperty of identifier

type paramList = 
	  Param of paramVar

type obj = 
	  Object of (objAssignable * expression) list
	
type statement = 
	  Expression of expression
	| Return of expression
	| Block of statement list
	| Literal of string
	| If of expression * statement list * statement list
	| While of whilesource * statement list
	| For of identifier * array * statement list
	| Code of paramList * statement list

type root = 
	  statement list
