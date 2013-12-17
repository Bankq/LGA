CC = ocamlc -rectypes
SRC = ../src

.PHONY: test_parser test clean

test_assign: handlero
	$(CC) -I $(SRC) -c test_for.ml
	$(CC) -I $(SRC) parser.cmo utils.cmo scanner.cmo codegen_handler.cmo test_for.cmo -o test_for

scanner:
	make -C $(SRC)

handlero: scanner
	$(CC) -I $(SRC) -c codegen_handler.ml

test: test_assign
	./test_for ./test_parser_in/ ./test_parser_out/
clean:
	rm -rf *.cmi *.cmo test_for
