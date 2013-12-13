CC = ocamlc
YACC = ocamlyacc
LEX = ocamllex

PARSER = parser
SCANNER = scanner
AST = ast
LGA = semantic
UTILS = utils


all: asto parsero scannero lgao utilso
	$(CC) $(PARSER).cmo $(UTILS).cmo $(SCANNER).cmo $(LGA).cmo -o $(LGA)
utilso: parsero
	$(CC) -c $(UTILS).ml
scannero: scanner utilso
	$(CC) -c $(SCANNER).ml
scanner:
	$(LEX) $(SCANNER).mll
parsero: parseri
	$(CC) -c $(PARSER).ml
parseri: parser asto
	$(CC) -c $(PARSER).mli
parser:
	$(YACC) $(PARSER).mly
asto:
	$(CC) -c $(AST).mli
lgao: parsero
	$(CC) -c $(LGA).ml

clean:
	rm -rf *.cmo *.cmi $(LGA) $(SCANNER).mli $(SCANNER).ml $(PARSER).mli $(PARSER).ml

