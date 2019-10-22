all:
	rm text.out || true
	fpc -otext.out text.pas
	rm text.o
	
nochecks:
	rm text_no_checks.out || true
	fpc -otext_no_checks.out text_no_checks.pas
	rm text_no_checks.o

tests:
	../../tests.sh text.out
