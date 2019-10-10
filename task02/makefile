all:
	rm series.out || true
	fpc -oseries.out series.pas
	rm series.o
	
tests:
	../tests.sh series.out
