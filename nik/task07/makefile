all: build run
	
run:
	clear
	./details.out

build:
	rm details.out || true
	fpc -odetails.out fuck.pas
	rm details.o || true

datagen:
	rm data_generator.out || true
	fpc -odata_generator.out data_generator.pas
	rm data_generator.o
	