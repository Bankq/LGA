%{open Ast %}

%token ASSIGN TERMINATOR RETURN STATEMENT INDENT OUTDENT
%token ARROW LBK RBK LBK RBK
%token LPAREN RPAREN PLUS MINUS TIMES DIVIDE
%token EQ NEQ MOD AND OR LT LEQ GT GEQ NOT COLON 
%token LBRACE RBRACE COMMA DOT NULL THIS
%token IF ELSE WHILE FOR FORIN
%token <string> IDENTIFIER
%token <float> NUM
%token <string>  STRING
%token <string> STATEMENT
%token <int> OUTDENT_COUNT
%token <bool> BOOL
%token EOF

%nonassoc ELSE
%right ASSIGN
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE MOD
%left AND OR 


%start expr
%type <Ast.expr> expr

%%
expr:
    | expr ASSIGN expr { Assign($1, $3)}
	| NUM			{ Num($1) }
	| IDENTIFIER			{ Id($1) }
