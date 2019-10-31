program filesystem;

uses
	SysUtils,
	Character;

type 
	part = record
	title : string;
	quantity : integer;
	price : double;
	end;

	part_file = file of part;

procedure search_by_title(var f : part_file);
var
	found : boolean = false;
	part_buffer : part;
	title : string;
begin
	writeln('enter part title to display:');
	write('> ');
	readln(title);
	reset(f);

	while not eof(f) do
	begin
		read(f, part_buffer);
		if (lowercase(part_buffer.title) = lowercase(title)) then
		begin
			found := true;

			writeln('part found');
			writeln('	title    : ', part_buffer.title);
			writeln('	quantity : ', part_buffer.quantity);
			writeln('	price    : ', part_buffer.price:5:2);
		end;
	end;

	if not found then
		writeln('part "', title, '" not found');
	found := false;
	reset(f);
end;


procedure search_by_price(var f : part_file);
var
	counter : integer = 1;
	part_buffer : part;
	price : double;
begin
	writeln('enter min price:');
	write('> ');
	readln(price);
	reset(f);

	while not eof(f) do
	begin
		read(f, part_buffer);
		if (part_buffer.price >= price) then
		begin
			writeln(counter, ':');
			writeln('	title    : ', part_buffer.title);
			writeln('	quantity : ', part_buffer.quantity);
			writeln('	price    : ', part_buffer.price:5:2);

			counter := counter + 1;
		end;
	end;

	reset(f);
end;

var
	title : string = '';
	database_file : part_file;
begin
	writeln('enter filename:');
	write('> ');

	{$I-}
	readln(title);
	{$I+}

	if (ioresult <> 0) or (title = '') then
	begin
		writeln('wrong filename');
		exit;
	end;

	{$I-}
	assign(database_file, title+'.bak');
	reset(database_file);
	{$I+}
	
	if (ioresult <> 0) or (title = '') then
	begin
		writeln('file "', title, '" not found or cannot be opened');
		exit;
	end;

	writeln('opened ', title);

	while true do
	begin
		writeln('enter operation [ part / price ]:');
		write('> ');
		readln(title);
		case title of
			'part': search_by_title(database_file);
			'price': search_by_price(database_file);
		else
			writeln('unknown operation');
		end;
		
	end;

end.