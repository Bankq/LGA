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

expression:
	| value { $1 } 
	| invocation { $1 } 
	| code { $1 }
	| operation { $1 }
	| assign { $1 }
	| if { $1 }
	| while { $1 }
	| for { $1 }

operation:
	| expression PLUS expression		{ Binop($1, Plus,$3) }
	| expression MINUS expression		{ Binop($1, Minus, $3) }
	| expression TIMES expression		{ Binop($1, Times, $3) }
	| expression DIVIDE expression		{ Binop($1, Divide, $3)}
	| expression EQ	expression		{ Binop($1, Eq, $3) }
	| expression NEQ expression		{ Binop($1, Neq, $3) }
	| expression MOD expression		{ Binop($1, Mod, $3) }
	| expression AND expression		{ Binop($1, And, $3) }
	| expression OR expression		{ Binop($1, OR, $3) }
	| expression LT expression		{ Binop($1, Less, $3) }
	| expression LEQ expression		{ Binop($1, Leq, $3) }
	| expression GT expression		{ Binop($1, Greater, $3) }
	| expression GEQ expression		{ Binop($1, Geq, $3) }
	| NOT expression			{ Neg($2) }

code:
	| LPAREN paramList RPAREN ARROW Block { Code($2, $5) }

value:
	| assignable { $1 }
	| literal { Value($1) }
	| parenthetical { Value($1) }

assign:
	| assignable ASSIGN expression                { Assign ($1, $3) }
	| assignable ASSIGN TERMINATOR expression     { Assign ($1, $4) }
	| assignable ASSIGN INDENT expression OUTDENT { Assign ($1, $4) }

assignable:
	| simpleAssignable { $1 }
	| array { Value($1) }
	| obj { Value($1) }

simpleAssignable:
	| identifier { $1 }
	| thisProperty { $1 }
	| accessor { $1 }

assignObj:
	| objAssignable COLON expression { AssginObj($1, $3) }
	| objAssignable COLON INDENT expression OUTDENT { AssignObj($1, $4) }
	
objAssignable:
	| identifiers { $1 }
	| thisProperty { $1 }

accessor:
	| DOT indentifier {???}
	| index {$1}
	
obj:
  | LBRACE assignList RBRACE { Object($2) }

assignList:
	| /* nothing */ { [] } 
	| assignObj { [$1] }
	| assignObj COMMA assignObj { List.append [$1] [$3] }
	| assignList COMMA TERMINATOR assignObj { List.append $1 $4 }
	| assignList COMMA INDENT assignList OUTDENT { List.append $1 $4 }

invocation:
	| value arguments	{ Invocation($1) }

arguments:
	| LPAREN RPAREN { [] }
	| LPAREN argList RPAREN { $2 }

argList:
	| expression { $1 } 
	| argList COMMA expression { List.append $1 $3 }
	| argList COMMA TERMINATOR expression { List.append $1 $4 }
	| INDENT argList OUTDENT { $2 }
	| argList COMMA INDENT argList OUTDENT { List.append $1 $4 }

paramList:
	| /* nothing */		{ [] }
	| param { $1 }
	| paramList COMMA param { List.append $1 $3 }
	| paramList COMMA TERMINATOR param { List.append $1 $4 }
	| paramList COMMA INDENT paramList OUTDENT {List.append $1 $4 }

param:
	| paramVar { Param($1) }

paramVar:
	| identifier { $1 }
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

identifier:
	IDENTIFIER	{ Id($1) }

literal:
	| NUM		{ Num($1) }
	| STRING	{ String($1) }
	| NULL		{ NULL() }
	| BOOL		{ Boolean{$1} }

thisProperty:
	| THIS identifier	{ ThisProperty($2) }

if:
	| ifBlock ELSE block	{ If($1, $3) }
	| ifBlock		{ IfOnly($1) }

ifBlock:
	| IF expression block			{ Ifblock($2, $3) }
	| IfBlock ELSE IF expression block	{ Ifblockseq($1, $4, $5) }

while:
	whileSource block		{ While($1, $2) }

whileSource:
	WHILE expression		{ WhileSource($2) }

for:
	forBody block			{ For($1, $2) }

forBody:
	forStart forSource		{ ForBody($1, $2) }

forStart:
	FOR forVar			{ ForStart($2) }

forVar:
	| forValue			{ ForVar([$1]) }

forValue:
	| identifier			{ $1 }

forSource:
	| FORIN expression		{ ForSource($2) }