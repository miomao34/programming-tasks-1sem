program filesystem;

uses
	SysUtils;

type 
detail = record
   detail_name : string;
   quantity : integer;
   place : string;
end;

var
	detail_buffer : detail;
	title : string = 'data.txt';
	database_file : file of detail;
begin
	assign(database_file, title);
	rewrite(database_file);
	
	detail_buffer.detail_name := 'C';
	detail_buffer.quantity    := 600;
	detail_buffer.place       := 'place3';
	write(database_file, detail_buffer);
	
	detail_buffer.detail_name := 'A';
	detail_buffer.quantity    := 400;
	detail_buffer.place       := 'place1';
	write(database_file, detail_buffer);
	
	detail_buffer.detail_name := 'B';
	detail_buffer.quantity    := 500;
	detail_buffer.place       := 'place1';
	write(database_file, detail_buffer);
	
	detail_buffer.detail_name := 'B';
	detail_buffer.quantity    := 100;
	detail_buffer.place       := 'place1';
	write(database_file, detail_buffer);
	
	detail_buffer.detail_name := 'A';
	detail_buffer.quantity    := 100;
	detail_buffer.place       := 'place3';
	write(database_file, detail_buffer);
	
	detail_buffer.detail_name := 'C';
	detail_buffer.quantity    := 300;
	detail_buffer.place       := 'place1';
	write(database_file, detail_buffer);
	
	detail_buffer.detail_name := 'A';
	detail_buffer.quantity    := 700;
	detail_buffer.place       := 'place4';
	write(database_file, detail_buffer);
	
	detail_buffer.detail_name := 'B';
	detail_buffer.quantity    := 200;
	detail_buffer.place       := 'place3';
	write(database_file, detail_buffer);

end.