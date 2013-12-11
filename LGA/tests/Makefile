CC = ocamlc
SRC = ../src

test_scanner: scanner utils
	$(CC) -I $(SRC) -c test_scanner.ml
	$(CC) -I $(SRC) parser.cmo scanner.cmo utils.cmo test_scanner.cmo -o test_scanner
utils:
	$(CC) -I $(SRC) -c utils.ml
scanner:
	make -C $(SRC)
clean:
	rm -rf *.cmi *.cmo utils.mli test_scanner
