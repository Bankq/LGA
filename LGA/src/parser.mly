%{open Ast %}

%token ASSIGN TERMINATOR RETURN INDENT OUTDENT
%token ARROW LBK RBK LBK RBK
%token LPAREN RPAREN PLUS MINUS TIMES DIVIDE
%token EQ NEQ MOD AND OR LT LEQ GT GEQ NOT COLON 
%token LBRACE RBRACE COMMA DOT BOOL THIS
%token IF ELSE WHILE FOR FORIN
%token <string> IDENTIFIER
%token <float> NUM
%token <string>  STRING
%token <string> STATEMENT
%token <int> OUTDENT_COUNT
%token <string> NULL
%token <bool> BOOL
%token EOF

%nonassoc ELSE
%right ASSIGN
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE MOD
%left AND OR 

%start root
%type <Ast.root> root

%%

root:
	| /* nothing */ { [] }
	| body { $1 }
	| block TERMINATOR { $1 }

body:
	| statement { [$1] }
	| body TERMINATOR statement { List.append $1 [$3] }
	| body TERMINATOR { $1 }


statement:
	| expression							{ Expression($1) }
	| return 								{ $1 }
	| STATEMENT 							{ Literal($1) }
	| IF expression block ELSE block 		{ If($2, $3, $5) }
	| IF expression block 					{ If($2, $3, []) }
	| WHILE expression block                { While{$2, $3} }
	| FOR identifier FORIN array block		{ For($2, $4, $5) }
	| LPAREN paramList RPAREN ARROW block 	{ Code($2, $5) }

return:
	| RETURN expression { Return($2) } 
	| RETURN { Return() }

assignList:
	| /* nothing */ { [] } 
	| assignObj { [$1] }
	| assignObj COMMA assignObj { List.append [$1] [$3] }
	| assignList optComma TERMINATOR assignObj { List.append $1 $4 }
	| assignList optComma INDENT assignList optComma OUTDENT { List.append $1 $4 }

expression:
	| value 							{ $1 } 
	| invocation 						{ $1 } 
	| assign 							{ $1 }
	| obj  								{ $1 }
	| expression PLUS expression		{ Binop($1, Plus,$3) }
	| expression MINUS expression		{ Binop($1, Minus, $3) }
	| expression TIMES expression		{ Binop($1, Times, $3) }
	| expression DIVIDE expression		{ Binop($1, Divide, $3)}
	| expression EQ	expression			{ Binop($1, Eq, $3) }
	| expression NEQ expression			{ Binop($1, Neq, $3) }
	| expression MOD expression			{ Binop($1, Mod, $3) }
	| expression AND expression			{ Binop($1, And, $3) }
	| expression OR expression			{ Binop($1, OR, $3) }
	| expression LT expression			{ Binop($1, Less, $3) }
	| expression LEQ expression			{ Binop($1, Leq, $3) }
	| expression GT expression			{ Binop($1, Greater, $3) }
	| expression GEQ expression			{ Binop($1, Geq, $3) }
	| NOT expression					{ Neg($2) }

obj:
	| LBRACE assignList optComma RBRACE { Object($2) }

value:
	| assignable { $1 }
	| literal { $1 }
 	| thisProperty { $1 }

assign:
	| assignable ASSIGN expression                { Assign ($1, $3) }
	| assignable ASSIGN TERMINATOR expression     { Assign ($1, $4) }
	| assignable ASSIGN INDENT expression OUTDENT { Assign ($1, $4) }

assignable:
	| identifier { $1 }
	| thisProperty { $1 }
	| value DOT identifier	{ Assignable($1, $3) }

assignObj:
	/*| objAssignable { ($1) }*/
	| objAssignable COLON expression { ($1, $3) }
	| objAssignable COLON INDENT expression OUTDENT { ($1, $4) }
	
objAssignable:
	| identifier 	{ $1 }
	| thisProperty 	{ $1 }


optComma:
	| /* nothing */	{ }
	| COMMA			{ }

invocation:
	| value arguments	{ Invocation($1, $2) }

arguments:
	| LPAREN RPAREN { [] }
	| LPAREN argList optComma RPAREN { $2 }

argList:
	| expression { $1 } 
	| argList COMMA expression { List.append $1 $3 }
	| argList optComma TERMINATOR expression { List.append $1 $4 }
	| INDENT argList optComma OUTDENT { $2 }
	| argList optComma INDENT argList optComma OUTDENT { List.append $1 $4 }

paramList:
	| /* nothing */		{ [] }
	| param { $1 }
	| paramList COMMA param { List.append $1 $3 }
	| paramList optComma TERMINATOR param { List.append $1 $4 }
	| paramList optComma INDENT paramList optComma OUTDENT {List.append $1 $4 }

param:
	| paramVar { Param($1) }
	| paramVar ASSIGN expression { Param($1, $3) }

paramVar:
	| identifier { $1 }
	| array { $1 }
	| obj { $1 }
	| thisProperty { $1 }

index:
	| LBK indexValue RBK { $2 }

indexValue:
	| expression { $1 }

array:
  | LBK RBK { Array([]) }
  | LBK argList RBK { Array($2) }

block:
	| INDENT OUTDENT { [] }
	| INDENT body OUTDENT { $2 }

identifier:
	IDENTIFIER	{ Id($1) }

alphaNumeric:
	| NUM		{ Num($1) }
	| STRING	{ String($1) }

literal:
	| alphaNumeric	{ $1 }
	| NULL		{ $1 }
	| BOOL		{ Boolean{$1} }

thisProperty:
	| THIS identifier	{ ThisProperty($2) }	
