%{open AST}%

%token ASSIGN

%right ASSIGN

%start program
%type <Ast.program> program

expr:
	| expr ASSIGN expr	{ Binop($1, ASSIGN, $3) }
