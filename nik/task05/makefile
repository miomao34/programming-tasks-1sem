all: filesystem data_generator

filesystem:
	rm filesystem.out || true
	fpc -ofilesystem.out filesystem.pas
	rm filesystem.o

data_generator:
	rm data_generator.out || true
	fpc -odata_generator.out data_generator.pas
	rm data_generator.o
	
tests:
	../../tests.sh filesystem.out
