DOC = ocamldoc -rectypes
SRC = LGA/src
REDIRECT = docs/

PARSER = LGA/src/parser
SCANNER = LGA/src/scanner
AST = LGA/src/ast
LGA = LGA/src/semantic
UTILS = LGA/src/utils

.PHONY: all clean

doc: all
	$(DOC) -I $(SRC) -d $(REDIRECT) -html -g $(SCANNER).ml $(PARSER).mli $(UTILS).ml $(LGA).ml
all:
	make -C $(SRC)
clean:
	rm -rf $(REDIRECT)*.html $(REDIRECT)*.css
