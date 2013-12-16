%{open Ast %}

%token ASSIGN TERMINATOR RETURN INDENT OUTDENT
%token ARROW LBK RBK LBK RBK
%token LPAREN RPAREN PLUS MINUS TIMES DIVIDE
%token EQ NEQ MOD AND OR LT LEQ GT GEQ NOT COLON 
%token LBRACE RBRACE COMMA DOT BOOL THIS
%token IF ELSE WHILE FOR FORIN
%token <string> IDENTIFIER
%token <string> NUM
%token <string>  STRING
%token <string> STATEMENT
%token <int> OUTDENT_COUNT
%token <string> NULL
%token <string> BOOL
%token FUN
%token EOF

%nonassoc ELSE
%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ 
%left PLUS MINUS
%left TIMES DIVIDE MOD
%right NOT

%start root
%type <Ast.root> root

%%

root:
	| /* nothing */ { [] }
	| body { $1 }
	| block TERMINATOR { $1 }

body:
	| line { [$1] }
	| body TERMINATOR line { List.append $1 [$3] }
	| body TERMINATOR { $1 }

line:
	| expression { ExpressionLine($1) }
	| statement { StatementLine($1) }

statement:
	| return { ReturnStatement($1) }
	| STATEMENT { LiteralStatement(Literal($1)) }

return:
	| RETURN expression { Return($2) } 

expression:
	| value { ValueExpression($1) } 
	| invocation { InvocationExpression($1) } 
	| code { CodeExpression($1) }
	| operation { OperationExpression($1) }
	| assign { AssignExpression($1) }
	| iftype { IfExpression($1) }
	| whiletype { WhileExpression($1) }
	| fortype { ForExpression($1) }

operation:
	| lop PLUS expression		{ Binop($1, Plus,$3) }
	| lop MINUS expression		{ Binop($1, Minus, $3) }
	| lop TIMES expression		{ Binop($1, Times, $3) }
	| lop DIVIDE expression		{ Binop($1, Divide, $3)}
	| lop EQ	expression		{ Binop($1, Eq, $3) }
	| lop NEQ expression		{ Binop($1, Neq, $3) }
	| lop MOD expression		{ Binop($1, Mod, $3) }
	| lop AND expression		{ Binop($1, And, $3) }
	| lop OR expression		    { Binop($1, Or, $3) }
	| lop LT expression		    { Binop($1, Less, $3) }
	| lop LEQ expression		{ Binop($1, Leq, $3) }
	| lop GT expression		    { Binop($1, Greater, $3) }
	| lop GEQ expression		{ Binop($1, Geq, $3) }
	| NOT expression			{ Neg($2) }

lop:
	| value { ValueLop($1) }
	| invocation { InvocationLop($1) }

code:
	| FUN LPAREN paramList RPAREN ARROW block { Code($3, $6) }

value:
    | assignable { AssignableValue($1) }
	| literal { LiteralValue($1) }
	| parenthetical { ParentheticalValue($1) }

assign:
	| assignable ASSIGN expression                { Assign ($1, $3) }
	| assignable ASSIGN TERMINATOR expression     { Assign ($1, $4) }
	| assignable ASSIGN INDENT expression OUTDENT { Assign ($1, $4) }

assignable:
	| array { ArrayAssignable($1) }
	| obj { ObjAssignable($1) }
	| identifier { IdentifierAssignable($1) }
	| thisProperty { ThisPropertyAssignable($1) }
	| value accessor { ValueAccessorAssignable($1, $2) }
	| invocation accessor { InvocationAccessorAssignable($1, $2) }

assignObj:
	| objAssignable COLON expression { AssignObj($1, $3) }
	| objAssignable COLON INDENT expression OUTDENT { AssignObj($1, $4) }
	
objAssignable:
	| identifier { IdentifierObjAssignable($1)}
	| thisProperty { ThisPropertyObjAssignable($1) }

accessor:
	| DOT identifier { DotAccessor($2) }
	| index { IndexAccessor($1) }
	
obj:
    | LBRACE assignList RBRACE { Object($2) }

assignList:
	| /* nothing */ { [] } 
	| assignObj { [$1] }
	| assignList COMMA assignObj { List.append $1 [$3] }
	| assignList COMMA TERMINATOR assignObj { List.append $1 [$4] }
	| assignList COMMA INDENT assignList OUTDENT { List.append $1 $4 }

invocation:
	| value arguments	{ Invocation($1, $2) }

arguments:
	| LPAREN RPAREN { [] }
	| LPAREN argList RPAREN { $2 }

argList:
	| expression { [$1] } 
	| argList COMMA expression { List.append $1 [$3] }
	| argList COMMA TERMINATOR expression { List.append $1 [$4] }
	| INDENT argList OUTDENT { $2 }
	| argList COMMA INDENT argList OUTDENT { List.append $1 $4 }

paramList:
	| /* nothing */		{ [] }
	| identifier { [$1] }
	| paramList COMMA identifier { List.append $1 [$3] }
	| paramList COMMA TERMINATOR identifier { List.append $1 [$4] }
	| paramList COMMA INDENT paramList OUTDENT {List.append $1 $4 }

index:
	| LBK indexValue RBK { Index($2) }

indexValue:
	| NUM { Literal($1) }

parenthetical:
	| LPAREN body RPAREN { Parenthetical($2) }
	| LPAREN INDENT body OUTDENT RPAREN { Parenthetical($3) }

array:
    | LBK RBK { [] }
    | LBK argList RBK { $2 }

block:
	| INDENT OUTDENT {[]}
	| INDENT body OUTDENT { $2 }

identifier:
	| IDENTIFIER	{ Literal($1) }

literal:
	| NUM		{ Literal($1) }
	| STRING	{ Literal($1) }
	| NULL		{ Literal($1) }
	| BOOL		{ Literal($1) }

thisProperty:
    | THIS identifier { $2}

iftype:
	| ifBlock		        { IfOnly($1) }
	| ifBlock ELSE block	{ IfElse($1, $3) }

ifBlock:
	| IF expression block			    { IfBlock($2, $3) }
	| ifBlock ELSE IF expression block	{ IfBlockSeq($1, $4, $5) }

whiletype:
	| whileSource block		{ While($1, $2) }

whileSource:
	| WHILE expression		{ WhileSource($2) }

fortype:
	| forBody block			{ For($1, $2) }

forBody:
	| forStart forSource		{ ForBody($1, $2) }

forStart:
	| FOR forVar			{ ForStart($2) }

forVar:
    | identifier 			{ ForVar($1) }

forSource:
	| FORIN expression		{ ForSource($2) }
