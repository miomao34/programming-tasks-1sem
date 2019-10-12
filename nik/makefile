all:
	rm strings.out || true
	fpc -ostrings.out strings.pas
	rm strings.o
	
nochecks:
	rm strings_no_checks.out || true
	fpc -ostrings_no_checks.out strings_no_checks.pas
	rm strings_no_checks.o

tests:
	../tests.sh strings.out
