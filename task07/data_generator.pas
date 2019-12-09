program filesystem;

uses
	SysUtils;

type 
passenger = record
   flight : integer;
   firstname : string;
   patro : string;
   surname : string;
   date : string;
   time : string;
   dest : string;
end;

var
	passenger_buffer : passenger;
	title : string = '';
	database_file : file of passenger;
begin
	writeln('enter filename:');
	write('> ');
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

	passenger_buffer.flight := 101;
	passenger_buffer.firstname := 'Igor';
	passenger_buffer.patro     := 'Ivanovich';
	passenger_buffer.surname   := 'Sikorsky';
	passenger_buffer.date := '30.05.1919';
	passenger_buffer.time := '11:32';
	passenger_buffer.dest := 'USA, New-York';
	write(database_file, passenger_buffer);
	writeln('ok: ', passenger_buffer.flight, ' - ', passenger_buffer.firstname, ' ', passenger_buffer.patro, ' ', passenger_buffer.surname, ' - ', passenger_buffer.date, ' ', passenger_buffer.time, ' - ', passenger_buffer.dest);

	passenger_buffer.flight := 845;
	passenger_buffer.firstname := 'Amelia';
	passenger_buffer.patro     := 'Mary';
	passenger_buffer.surname   := 'Earhart';
	passenger_buffer.date := '02.07.1937';
	passenger_buffer.time := '15:44';
	passenger_buffer.dest := 'USA, Howland Island';
	write(database_file, passenger_buffer);
	writeln('ok: ', passenger_buffer.flight, ' - ', passenger_buffer.firstname, ' ', passenger_buffer.patro, ' ', passenger_buffer.surname, ' - ', passenger_buffer.date, ' ', passenger_buffer.time, ' - ', passenger_buffer.dest);
	
	passenger_buffer.flight := 845;
	passenger_buffer.firstname := 'George';
	passenger_buffer.patro     := 'Palmer';
	passenger_buffer.surname   := 'Putham';
	passenger_buffer.date := '02.07.1937';
	passenger_buffer.time := '15:44';
	passenger_buffer.dest := 'USA, Howland Island';
	write(database_file, passenger_buffer);
	writeln('ok: ', passenger_buffer.flight, ' - ', passenger_buffer.firstname, ' ', passenger_buffer.patro, ' ', passenger_buffer.surname, ' - ', passenger_buffer.date, ' ', passenger_buffer.time, ' - ', passenger_buffer.dest);

	passenger_buffer.flight := 652;
	passenger_buffer.firstname := 'William';
	passenger_buffer.patro     := 'Edward';
	passenger_buffer.surname   := 'Boeing';
	passenger_buffer.date := '19.11.1916';
	passenger_buffer.time := '16:52';
	passenger_buffer.dest := 'USA, New York';
	write(database_file, passenger_buffer);
	writeln('ok: ', passenger_buffer.flight, ' - ', passenger_buffer.firstname, ' ', passenger_buffer.patro, ' ', passenger_buffer.surname, ' - ', passenger_buffer.date, ' ', passenger_buffer.time, ' - ', passenger_buffer.dest);

	passenger_buffer.flight := 325;
	passenger_buffer.firstname := 'Andrei';
	passenger_buffer.patro     := 'Nikolayevich';
	passenger_buffer.surname   := 'Tupolev';
	passenger_buffer.date := '03.10.1968';
	passenger_buffer.time := '18:35';
	passenger_buffer.dest := 'Russia, Moscow';
	write(database_file, passenger_buffer);
	writeln('ok: ', passenger_buffer.flight, ' - ', passenger_buffer.firstname, ' ', passenger_buffer.patro, ' ', passenger_buffer.surname, ' - ', passenger_buffer.date, ' ', passenger_buffer.time, ' - ', passenger_buffer.dest);

	passenger_buffer.flight := 325;
	passenger_buffer.firstname := 'Pavel';
	passenger_buffer.patro     := 'Osipovich';
	passenger_buffer.surname   := 'Sukhoi';
	passenger_buffer.date := '03.10.1968';
	passenger_buffer.time := '18:35';
	passenger_buffer.dest := 'Russia, Moscow';
	write(database_file, passenger_buffer);
	writeln('ok: ', passenger_buffer.flight, ' - ', passenger_buffer.firstname, ' ', passenger_buffer.patro, ' ', passenger_buffer.surname, ' - ', passenger_buffer.date, ' ', passenger_buffer.time, ' - ', passenger_buffer.dest);

	passenger_buffer.flight := 325;
	passenger_buffer.firstname := 'Alexander';
	passenger_buffer.patro     := 'Sergeyevich';
	passenger_buffer.surname   := 'Yakovlev';
	passenger_buffer.date := '03.10.1968';
	passenger_buffer.time := '18:35';
	passenger_buffer.dest := 'Russia, Moscow';
	write(database_file, passenger_buffer);
	writeln('ok: ', passenger_buffer.flight, ' - ', passenger_buffer.firstname, ' ', passenger_buffer.patro, ' ', passenger_buffer.surname, ' - ', passenger_buffer.date, ' ', passenger_buffer.time, ' - ', passenger_buffer.dest);
end.