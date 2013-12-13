%{open Ast %}

%token ASSIGN TERMINATOR RETURN STATEMENT INDENT OUTDENT
%token ARROW LBK RBK LBK RBK
%token LPAREN RPAREN PLUS MINUS TIMES DIVIDE
%token EQ NEQ MOD AND OR LT LEQ GT GEQ NOT COLON 
%token LBRACE RBRACE COMMA DOT NULL BOOL THIS
%token IF ELSE WHILE FOR FORIN
%token <string> IDENTIFIER
%token <float> NUM
%token <string>  STRING
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
	| line { $1 }
	| body TERMINATOR line { List.append $1 [$3] }
	| body TERMINATOR { $1 }

line:
	| expression { $1 }
	| statement { $1 }

statement:
	| return { $1 }
	| STATEMENT { Literal($1) }

return:
	| RETURN expression { Return($2) } 
	| RETURN { Return() }

expression:
	| value 							{ $1 } 
	| invocation 						{ $1 } 
	| code 								{ $1 }
	| assign 							{ $1 }
	| ifBlock ELSE block				{ If($1, $3) }
	| ifBlock							{ IfOnly($1) }
	| WHILE expression block			{ While{$2, $3} }
	| FOR identifier FORIN array block	{ For($1, $2, $3) }
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
	| NOT expression					{ Not($2) }



code:
	| LPAREN paramList RPAREN ARROW block { Code($2, $5) }

value:
	| assignable { $1 }
	| literal { $1 }
	| parenthetical { Value($1) }
 	| thisProperty { $1 }

assign:
	| assignable ASSIGN expression                { Assign ($1, $3) }
	| assignable ASSIGN TERMINATOR expression     { Assign ($1, $4) }
	| assignable ASSIGN INDENT expression OUTDENT { Assign ($1, $4) }

/*Assignable:
	| SimpleAssignable { $1 }
	| Array { Value($1) }
	| Object { Value($1) }
 */

assignable:
	| identifier { $1 }
	| thisProperty { $1 }
	| value DOT identifier	{ Assignable($1, $3) }

assignObj:
	| objAssignable { $1 }
	| objAssignable COLON expression { AssginObj($1, $3) }
	| objAssignable COLON INDENT expression OUTDENT { AssignObj($1, $4) }
	
objAssignable:
	| identifiers { $1 }
	| thisProperty { $1 }
	
obj:
  | LBRACE assignList optComma RBRACE { Object($2) }

optComma:
	| /* nothing */	{ }
	| COMMA		{ $1 }

assignList:
	| /* nothing */ { [] } 
	| assignObj { [$1] }
	| assignObj COMMA assignObj { List.append [$1] [$3] }
	| assignList optComma TERMINATOR assignObj { List.append $1 $4 }
	| assignList optComma INDENT assignList optComma OUTDENT { List.append $1 $4 }

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

parenthetical:
	| LPAREN body RPAREN { Parenthetical($2) }
	| LPAREN INDENT body OUTDENT RPAREN { Parenthetical($3) }

array:
  | LBK RBK { Array([]) }
  | LBK arglist RBK { Array($2) }

block:
	| INDENT OUTDENT { [] }
	| INDENT body OUTDENT { $2 }

/* Identifier */
/* description:
 *	Identifier:
 *		IDENTIFIER
 */

identifier:
	IDENTIFIER	{ Id($1) }

/* AlphaNumeric */
/* description:
 *	AlphaNumeric:
 *		NUMBER
 *		STRING
 */

alphaNumeric:
	| NUM		{ Num($1) }
	| STRING	{ String($1) }


/* Literal */
/* description:
 *	Literal:
 *		AlphaNumeric
 *		NULL
 *		BOOL
 */

literal:
	| alphaNumeric	{ $1 }
	| NULL		{ $1 }
	| BOOL		{ Boolean{$1} }

/* This */
/* description:
 * 	This:
 *		THIS
 *		@
 */

thisProperty:
	| THIS identifier	{ ThisProperty($2) }


/* If */
/* description:
 *	If:	
 *		Ifblock
 *		Ifblock ELSE block
 *		statement POST_IF expression
 *		expression POST_IF expression
 */

/*
if:
	| ifBlock ELSE block	{ If($1, $3) }
	| ifBlock		{ IfOnly($1) }
*/

/* Ifblock */
/* description:
 *	Ifblock:
 *		IF expression block
 *		Ifblock ELSE IF expression block
 */

ifBlock:
	| IF expression block			{ IfBlock($2, $3) }
	| ifBlock ELSE IF expression block	{ IfBlockseq($1, $4, $5) }

/*		
/* While */
/* description:
 * 	While:
 *		WhileSource block
 */

while:
	whileSource block		{ While($1, $2) }

/* WhileSource */
/* description:
 *	WhileSource:
 *		WHILE expression
 */

whileSource:
	WHILE expression		{ WhileSource($2) }
*/
/*
while:
	WHILE expression block			{ While{$2, $3} }
*/
/* For */
/* description 
 * 	For:
 *		FirBody block
 */
 /*
for:
	FOR identifier FORIN array block	{ For($1, $2, $3) }
*/
/*
for:
	forBody block			{ For($1, $2) }

forBody:
	forStart forSource		{ ForBody($1, $2) }

forStart:
	FOR forVar			{ ForStart($2) }

forVar:
	| forValue			{ ForVar([$1]) }
	| forValue, forValue		{ ForVar([$1; $2]) }

forValue:
	| identifier			{ $1 }
	| array				{ $1 }
	| obj			{ $1 }

forSource:
	| FORIN expression		{ ForSource($2) }

*/
