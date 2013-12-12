%{open Ast %}

%token INDENT
%token DEDENT
%token <int> DEDENT_COUNT
%token ASSIGN
%token EOF
%token <string> ID
%token <float> NUM

%right ASSIGN

%start expr
%type <Ast.expr> expr

%%
expr:
    | expr ASSIGN expr { Assign($1, $3)}
	| NUM			{ Num($1) }
	| ID			{ Id($1) }
