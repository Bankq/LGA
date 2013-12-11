CC = ocamlc
YACC = ocamlyacc
LEX = ocamllex

PARSER = parser
SCANNER = scanner
AST = ast
LGA = lga


all: asto parsero scannero lgao
	$(CC) $(PARSER).cmo $(SCANNER).cmo $(LGA).cmo -o $(LGA)
scannero: scanner
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

