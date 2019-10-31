all:
	rm length_sort.out || true
	fpc -olength_sort.out length_sort.pas
	rm length_sort.o
	
tests:
	../tests.sh length_sort.out
