%{open AST %}

%token ASSIGN
%token EOF
%token <string> ID
%token <float> NUM

%right ASSIGN

%start program
%type <Ast.program> program

expr:
	| NUM			{ NUM($1) }
	| ID			{ ID($1) }
	| expr ASSIGN expr	{ Binop($1, ASSIGN, $3) }
