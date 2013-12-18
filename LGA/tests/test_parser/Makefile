CC = ocamlc -rectypes
SRC = ../../src

.PHONY: test_parser test clean

test_assign: handlero
	$(CC) -I $(SRC) -c test_parser.ml
	$(CC) -I $(SRC) parser.cmo utils.cmo scanner.cmo test_parser_handler.cmo test_parser.cmo -o test_parser

scanner:
	make -C $(SRC)

handlero: scanner
	$(CC) -I $(SRC) -c test_parser_handler.ml

test: test_assign
	./test_parser ./test_parser_in/ ./test_parser_out/
clean:
	rm -rf *.cmi *.cmo test_parser
