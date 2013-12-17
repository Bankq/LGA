CC = ocamlc -rectypes
SRC = ../src

.PHONY: test_parser test clean

test_assign: handlero
	$(CC) -I $(SRC) -c test_codegen.ml
	$(CC) -I $(SRC) parser.cmo utils.cmo scanner.cmo codegen_handler.cmo test_codegen.cmo -o test_codegen

scanner:
	make -C $(SRC)

handlero: scanner
	$(CC) -I $(SRC) -c codegen_handler.ml

clean:
	rm -rf *.cmi *.cmo test_for
