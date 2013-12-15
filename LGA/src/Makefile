CC = ocamlc -rectypes
YACC = ocamlyacc
LEX = ocamllex

PARSER = parser
SCANNER = scanner
AST = ast
SEMANTIC = semantic
UTILS = utils

all: asti parsero scannero semantico utilso
	$(CC) $(UTILS).cmo $(PARSER).cmo $(SCANNER).cmo $(SEMANTIC).cmo -o $(SEMANTIC)
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
semantico: asti parsero
	$(CC) -c $(SEMANTIC).ml

clean:
	rm -rf *.cmo *.cmi $(SEMANTIC) $(SCANNER).mli $(SCANNER).ml $(PARSER).mli $(PARSER).ml

