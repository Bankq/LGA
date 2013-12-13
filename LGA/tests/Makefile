CC = ocamlc
SRC = ../src

.PHONY: scanner test clean

test_scanner: scanner
	$(CC) -I $(SRC) -c test_scanner.ml
	$(CC) -I $(SRC) parser.cmo utils.cmo scanner.cmo test_scanner.cmo -o test_scanner
scanner:
	make -C $(SRC)
test: test_scanner
	./test_scanner ./test_in/ ./test_out/
clean:
	rm -rf *.cmi *.cmo test_scanner
