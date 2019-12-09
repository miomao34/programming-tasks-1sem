all:
	rm flights.out || true
	fpc -oflights.out flights.pas
	rm flights.o

run:
	/home/sinclair43/Documents/misc/cool-retro-terminal/Cool_Retro_Term-64e007f-x86_64.AppImage --workdir /home/sinclair43/Documents/fMephi/programming/programming-tasks-1sem/task07

datagen:
	rm data_generator.out || true
	fpc -odata_generator.out data_generator.pas
	rm data_generator.o
	
# tests:
# 	../tests.sh flights.out
