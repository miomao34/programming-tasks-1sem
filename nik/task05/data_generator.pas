program filesystem;

uses
	SysUtils;

type 
part = record
   title : string;
   quantity : integer;
   price : double;
end;

var
	part_buffer : part;
	title : string = '';
	database_file : file of part;
begin
	write('enter filename: ');
	readln(title);

	{$I-}
	assign(database_file, title+'.bak');
	// reset(database_file);
	// append(database_file);
	rewrite(database_file);
	{$I+}
	
	if (ioresult <> 0) or (title = '') then
	begin
		writeln('file ', title, ' not found or cannot be opened');
		exit;
	end;

	writeln('opened ', title);
	writeln('writing:');

	part_buffer.title := 'panel';
	part_buffer.quantity := 328;
	part_buffer.price := 44.60;
	write(database_file, part_buffer);
	writeln('written: ', part_buffer.title, ' - ', part_buffer.quantity, ' - ', part_buffer.price:6:2);

	part_buffer.title := 'bolt';
	part_buffer.quantity := 1015;
	part_buffer.price := 0.04;
	write(database_file, part_buffer);
	writeln('written: ', part_buffer.title, ' - ', part_buffer.quantity, ' - ', part_buffer.price:6:2);

	part_buffer.title := 'nut';
	part_buffer.quantity := 1018;
	part_buffer.price := 0.05;
	write(database_file, part_buffer);
	writeln('written: ', part_buffer.title, ' - ', part_buffer.quantity, ' - ', part_buffer.price:6:2);

	part_buffer.title := 'box';
	part_buffer.quantity := 664;
	part_buffer.price := 2.58;
	write(database_file, part_buffer);
	writeln('written: ', part_buffer.title, ' - ', part_buffer.quantity, ' - ', part_buffer.price:6:2);

	part_buffer.title := 'canister';
	part_buffer.quantity := 225;
	part_buffer.price := 12.25;
	write(database_file, part_buffer);
	writeln('written: ', part_buffer.title, ' - ', part_buffer.quantity, ' - ', part_buffer.price:6:2);

	part_buffer.title := 'vent';
	part_buffer.quantity := 124;
	part_buffer.price := 24.12;
	write(database_file, part_buffer);
	writeln('written: ', part_buffer.title, ' - ', part_buffer.quantity, ' - ', part_buffer.price:6:2);
	
	part_buffer.title := 'barrel';
	part_buffer.quantity := 126;
	part_buffer.price := 22.18;
	write(database_file, part_buffer);
	writeln('written: ', part_buffer.title, ' - ', part_buffer.quantity, ' - ', part_buffer.price:6:2);
end.