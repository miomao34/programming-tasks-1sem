all:
	rm list.out || true
	fpc -olist.out list.pas
	rm list.o
	
tests:
	../tests.sh list.out
