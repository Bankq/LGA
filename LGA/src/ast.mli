type expr = 
	| Assign of string * expr
	| Id of string
	| Num of float
