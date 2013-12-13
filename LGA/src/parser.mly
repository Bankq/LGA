%{open Ast %}

%token TERMINATOR
%token INDENT
%token OUTDENT
%token <int> OUTDENT_COUNT
%token ASSIGN
%token EOF
%token <string> IDENTIFIER
%token <float> NUM

%right ASSIGN

%start expr
%type <Ast.expr> expr

%%
expr:
    | expr ASSIGN expr { Assign($1, $3)}
	| NUM			{ Num($1) }
	| IDENTIFIER			{ Id($1) }
