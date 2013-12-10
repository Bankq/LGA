#all: ast.cmi, compiler
#compiler: scanner.cmo, parser.cmo

scanner.cmo: scanner.ml
	ocamlc -c scanner.ml

scanner.ml: scanner.mll
	ocamllex scanner.mll

parser.cmo: parser.ml
	ocamlc -c parser.ml

parser.ml: parser.mli
	ocamlc -c parser.mli

parser.mli: parser.mli
	ocamlyacc parser.mly

ast.cmi: ast.mli
	ocamlc -c ast.mli
