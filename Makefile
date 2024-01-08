build:
	dune build

start:
	OCAMLRUNPARAM=b dune exec bin/main.exe

test:
	OCAMLRUNPARAM=b dune exec tests/test.exe