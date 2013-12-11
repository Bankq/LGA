CC = ocamlc
SRC = ../src

test_scanner: scanner
	$(CC) -I $(SRC) -c test_scanner.ml
	$(CC) -I $(SRC) parser.cmo scanner.cmo test_scanner.cmo -o test_scanner
scanner:
	make -C $(SRC)
clean:
	rm -rf *.cmi *.cmo test_scanner
