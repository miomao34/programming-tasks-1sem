all:
	rm strings.out || true
	fpc -ostrings.out strings.pas
	rm strings.o
	
tests:
	../tests.sh strings.out
