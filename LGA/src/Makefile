CC = ocamlc -rectypes
YACC = ocamlyacc
LEX = ocamllex

PARSER = parser
SCANNER = scanner
AST = ast
SEMANTIC = semantic
LGA = lga
UTILS = utils
CODEGEN = codegen

all: codegeno
	$(CC) $(UTILS).cmo $(PARSER).cmo $(SCANNER).cmo $(SEMANTIC).cmo $(CODEGEN).cmo -o $(LGA)c
utilso: parsero
	$(CC) -c $(UTILS).ml
scannero: scanner utilso
	$(CC) -c $(SCANNER).ml
scanner:
	$(LEX) $(SCANNER).mll
parsero: parseri
	$(CC) -c $(PARSER).ml
parseri: parser asti
	$(CC) -c $(PARSER).mli
parser:
	$(YACC) $(PARSER).mly
asti:
	$(CC) -c $(AST).mli
semantico: asti lgai parsero scannero
	$(CC) -c $(SEMANTIC).ml
lgai:
	$(CC) -c $(LGA).mli
codegeno: semantico
	$(CC) -c $(CODEGEN).ml
token: scannero parsero
	$(CC) -c token.ml
	$(CC) $(UTILS).cmo $(PARSER).cmo $(SCANNER).cmo token.cmo -o token

clean:
	rm -rf *.cmo *.cmi $(CODEGEN) $(SCANNER).mli $(SCANNER).ml $(PARSER).mli $(PARSER).ml token

