%{open Ast %}

%token ASSIGN TERMINATOR HERECOMMENT RETURN STATEMENT INDENT OUTDENT ARROW
%token LBK RBK
%token EOF

%right ASSIGN

%start expr
%type <Ast.expr> expr

%%

Root:
	| /* nothing */ { [] }
	| Body { $1 }
	| Block TERMINATOR { $1 }

Body:
	| Line { $1 }
	| Body TERMINATOR Line { List.append $1 [$3] }
	| Body TERMINATOR { $1 }

Line:
	| Expression { $1 }
	| Statement { $1 }

Statement:
	| Return { $1 }
	| Comment { $1 }
	| STATEMENT { Literal($1) }

Return:
	| RETURN Expression { Return($2) } 
	| RETURN { Return() }

Comment:
	| HERECOMMENT { Comment($1) }

Expression:
	| Value { $1 } 
	| Invocation { $1 } 
	| Code { $1 }
	| Operation { $1 }
	| Assign { $1 }
	| If { $1 }
	| While { $1 }
	| For { $1 }

Code:
	| PARAM_START ParamList PARAM_END ARROW Bock { Code($2, $5) }
	| ARROW Block { Code([], $2) }

Value:
	| Assignable { $1 }
	| Literal { Value($1) }
	| Parenthetical { Value($1) }
 	| This { $1 }

Assign:
	| Assignable ASSIGN Expression                { Assign ($1, $3) }
	| Assignable ASSIGN TERMINATOR Expression     { Assign ($1, $4) }
	| Assignable ASSIGN INDENT Expression OUTDENT { Assign ($1, $4) }

Assignable:
	| SimpleAssignable { $1 }
	| Array { Value($1) }
	| Object { Value($1) }

SimpleAssignable:
	| Identifier { $1 }
	| ThisProperty { $1 }

AssignObj:
	| ObjAssignable { $1 }
	| ObjAssignable COLON Expression { AssginObj($1, $3) }
	| ObjAssignable COLON INDENT Expression OUTDENT { AssignObj($1, $4) }
	| Comment { $1 }
	
ObjAssignable:
	|	Identifiers { $1 }
	| AlphaNumeric { $1 }
	| ThisProperty { $1 }
	
Object:
  | LBRACE AssignList OptComma RBRACE { Object($2) }

AssignList:
	| NULL { [] } 
	| AssignObj { [$1] }
	| AssignObj COMMA AssignObj { List.append $1 $3 }
	| AssignList OptComma TERMINATOR AssignObj { List.append $1 $4 }
	| AssignList OptComma INDENT AssignList OptComma OUTDENT { List.append $1 $4 }

Invocation:
	| Value Arguments { Invocation($1, $2) }

Arguments:
	| CALL_START CALL_END { [] }
	| CALL_START ArgList OptComma CALL_END { $2 }

ArgList:
	| Expression { $1 } 
	| ArgList COMMA Expression { List.append $1 $3 }
	| ArgList OptComma TERMINATOR Expression { List.append $1 $4 }
	| INDENT ArgList OptComma OUTDENT {$ 2}
	| ArgList OptComma INDENT ArgList OptComma OUTDENT { List.append $1 $4 }

ParamList:
	| NULL
	| Param { $1 }
	| ParamList COMMA Param { List.append $1 $3 }
	| ParamList OptComma TERMINATOR Param { List.append $1 $4 }
	| ParamList OptComma INDENT ParamList OptComma OUTDENT {List.append $1 $4 }

Param:
	| ParamVar { Param($1) }
	| ParamVar ASSIGN Expression { Param($1, $3) }

ParamVar:
	| Identifier { $1 }
	| Array { $1 }
	| Object { $1 }
	| ThisProperty { $1 }

Index:
	| INDEX_START IndexValue INDEX_END { $2 }

IndexValue:
	| Expression { $1 }

Parenthetical:
	| LPAREN Body RPAREN { Parenthetical($2) }
	| LPAREN INDENT Body OUTDENT RPAREN { Parenthetical($3) }

Array:
  | LBK RBK { Array([]) }
  | LBK Arglist RBK { Array($2) }

Block:
	| INDENT OUTDENT { [] }
	| INDENT Body OUTDENT { $2 }

/* Identifier */
/* description:
 *	Identifier:
 *		IDENTIFIER
 */

Identifier:
	IDENTIFIER	{ Id($1) }

/* AlphaNumeric */
/* description:
 *	AlphaNumeric:
 *		NUMBER
 *		STRING
 */

Alphanum:
	| NUM		{ Num($1) }
	| STRING	{ String($1) }


/* Literal */
/* description:
 *	Literal:
 *		AlphaNumeric
 *		NULL
 *		BOOL
 */

Literal:
	| alphanum	{ $1 }
	| NULL		{ NULL() }
	| BOOL		{ Boolean{$1} }

/* This */
/* description:
 * 	This:
 *		THIS
 *		@
 */

Thisproperty:
	| THIS identifier	{ ThisPro($2) }


/* If */
/* description:
 *	If:	
 *		IfBlock
 *		IfBlock ELSE Block
 *		statement POST_IF Expression
 *		Expression POST_IF Expression
 */

If:
	| IfBlock ELSE Block	{ If($1, $3) }
	| IfBlock		{ IfOnly($1) }

/* IfBlock */
/* description:
 *	IfBlock:
 *		IF Expression Block
 *		IfBlock ELSE IF Expression Block
 */

IfBlock:
	| IF Expression Block			{ Ifblock($2, $3) }
	| IfBlock ELSE IF Expression Block	{ Ifblockseq($1, $4, $5) }

		
/* While */
/* description:
 * 	While:
 *		WhileSource Block
 */

While:
	WhileSource Block		{ While($1, $2) }

/* WhileSource */
/* description:
 *	WhileSource:
 *		WHILE Expression
 */

WhileSource:
	WHILE Expression		{ WhileSource($1) }

/* For */
/* description 
 * 	For:
 *		FirBody Block
 */

For:
	ForBody Block			{ For($1, $2) }

ForBody:
	ForStart ForSource		{ ForBody($1, $2) }

ForStart:
	FOR ForVar			{ ForStart($2) }

ForVar:
	| ForValue			{ ForVar([$1]) }
	| ForValue, ForValue		{ ForVar([$1; $2]) }

ForValue:
	| Identifier			{ $1 }
	| Array				{ $1 }
	| Object			{ $1 }

ForSource:
	| FORIN Expression		{ ForSource($2) }


	