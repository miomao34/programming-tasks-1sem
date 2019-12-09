program list;

uses
	SysUtils,
	Character;


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

passArray = array of passenger;

flight = record
	flight : integer;
	passengers : passArray;
end;

flightArray = array of flight;

function read_word() : string;
var
	buffer : char;
	output : string = '';
begin
	if eof() then
		exit(output);
	
	read(buffer);
	while (not isLetterOrDigit(buffer)) and (not eof()) do
		read(buffer);
	
	if eof() then
		exit(output);

	output := output + buffer;

	while (isLetterOrDigit(buffer)) and (not eof()) do
	begin
		read(buffer);
		if isLetterOrDigit(buffer) then
			output := output + buffer;
	end;

	exit(output);
end;



function flight_in(flight_num : integer; var flights : flightArray) : integer;
var
	i : integer;
begin
	i := 0;
	for i := 0 to length(flights)-1 do
	begin
		if flights[i].flight = flight_num then
			exit(i);
	end;
	exit(-1);
end;


function comparator(left : flight; right : flight) : integer;
begin
	// writeln('comp: ', (left), '-', (right), '=', length(left) - length(right));
	exit (left.flight-right.flight);
end;

procedure sort(var input : flightArray);
Var
	i, j : integer;
	buf : flight;
begin
	// writeln(size);
	for i := 0 to length(input)-1 do
	begin
		buf := input[i];
		// writeln('!!!', buf);
		j := i;
		while ((j > 0) and (comparator(input[j-1], buf) > 0)) do
		begin
			input[j] := input[j-1];
			j := j - 1;
		end;
		input[j] := buf;
	end;
end;

var
	input : passArray;
	by_flight : flightArray;
	flighter : flight;
	title : string;
	firstname : string;
	found : boolean;
	selector : char;
	database_file : file of passenger;
	entry : passenger;
	i : integer = 0;
	current_flight : integer = 0;
	label another_file;
begin

another_file:

	writeln('enter database filename:');
	write('> ');
	readln(title);

	{$I-}
	assign(database_file, title+'.bak');
	reset(database_file);
	// rewrite(database_file);
	{$I+}
	
	if (ioresult <> 0) or (title = '') then
	begin
		writeln('file ', title, ' cannot be opened');
		writeln();
		goto another_file;
	end;

	writeln('opened ', title);

	setLength(input, 0);
	setLength(by_flight, 0);

	while not eof(database_file) do
	begin
		setLength(input, length(input)+1);
		read(database_file, input[length(input) - 1]);
	end;

	close(database_file);
	
	// for entry in input do
	// begin
	// 	writeln('ok: ', entry.flight, ' - ', entry.firstname, ' ', entry.patro, ' ', entry.surname, ' - ', entry.date, ' ', entry.time, ' - ', entry.dest);
	// end;

	for entry in input do
	begin
		current_flight := flight_in(entry.flight, by_flight);
		if current_flight = -1 then
		begin
			setLength(by_flight, length(by_flight)+1);
			by_flight[length(by_flight)-1].flight := entry.flight;
			setLength(by_flight[length(by_flight)-1].passengers, 1);
			by_flight[length(by_flight)-1].passengers[0] := entry;
		end
		else
		begin
			setLength(by_flight[current_flight].passengers, length(by_flight[current_flight].passengers)+1);
			by_flight[current_flight].passengers[length(by_flight[current_flight].passengers)-1] := entry;
		end;
	end;

	// for flighter in by_flight do
	// begin
	// 	writeln('flight ', flighter.flight);
	// 	for entry in flighter.passengers do
	// 	begin
	// 		writeln('    ', entry.flight, ' - ', entry.firstname, ' ', entry.patro, ' ', entry.surname, ' - ', entry.date, ' ', entry.time, ' - ', entry.dest);
	// 	end;
	// end;

	writeln('sorting...');
	sort(by_flight);
	
	// for flighter in by_flight do
	// begin
	// 	writeln('flight ', flighter.flight);
	// 	for entry in flighter.passengers do
	// 		writeln('    ', entry.flight, ' - ', entry.firstname, ' ', entry.patro, ' ', entry.surname, ' - ', entry.date, ' ', entry.time, ' - ', entry.dest);
	// 	writeln();
	// end;

	while true do
	begin
		writeln('enter operation: ');
		writeln('    [w]rite data out');
		writeln('    [l]oad another file');
		writeln('    [d]isplay flights');
		writeln('    [f]light passengers');
		writeln('    [s]earch for passenger');
		writeln('    [a]dd new passenger');
		writeln('    [p]rint all passengers');
		writeln('    [q]uit');
		write('> ');
		readln(selector);

		case tolower(selector) of
		'w':
			begin
				writeln('enter database filename:');
				write('> ');
				readln(title);

				{$I-}
				assign(database_file, title+'.bak');
				// reset(database_file);
				rewrite(database_file);
				{$I+}

				if (ioresult <> 0) or (title = '') then
				begin
					writeln('file ', title, ' not found or cannot be opened');
					exit;
				end;

				for flighter in by_flight do
				begin
					for entry in flighter.passengers do
					begin
						write(database_file, entry);
					end;
				end;
				writeln('written');
			end;
		
		'l':	goto another_file;
		'd':
			begin
				for flighter in by_flight do
					writeln(flighter.flight);
				writeln();
			end;

		'f':
			begin
				writeln('enter flight number:');
				write('> ');
				readln(current_flight);
				current_flight := flight_in(current_flight, by_flight);
				if current_flight = -1 then
				begin
					writeln('flight not found');
					continue;
				end;

				for entry in by_flight[current_flight].passengers do
				begin
					writeln('ok: ', entry.flight, ' - ', entry.firstname, ' ', entry.patro, ' ', entry.surname, ' - ', entry.date, ' ', entry.time, ' - ', entry.dest);
				end;
			end;

		's':
			begin
				writeln('enter passenger name:');
				write('> ');
				{$I-}
				readln(firstname);
				{$I+}

				if (ioresult <> 0) or (firstname = '') then
				begin
					writeln('incorrect value');
					continue;
				end;
				found := false;

				for flighter in by_flight do
				begin
					for entry in flighter.passengers do
					begin
						if tolower(entry.firstname) = tolower(firstname) then
						begin
							writeln('    ', entry.flight, ' - ', entry.firstname, ' ', entry.patro, ' ', entry.surname, ' - ', entry.date, ' ', entry.time, ' - ', entry.dest);
							found := true;
						end;
					end;
				end;
				if not found then
					writeln('passenger not found');
				writeln();
			end;

		'a':
			begin
				writeln('enter new passenger:');
				writeln('[flight] [name] [patro] [surname] [date] [time] [dest]');
				write('> ');
				{$I-}
				readln(entry.flight);
				readln(entry.firstname);
				readln(entry.patro);
				readln(entry.surname);
				readln(entry.date);
				readln(entry.time);
				readln(entry.dest);
				{$I+}
				
				if (ioresult <> 0) or (entry.firstname = '') or (entry.patro = '') or (entry.surname = '') or (entry.date = '') or (entry.time = '') or (entry.dest = '') then
				begin
					writeln('incorrect format of passenger record:');
					writeln('    ', entry.flight, ' - ', entry.firstname, ' ', entry.patro, ' ', entry.surname, ' - ', entry.date, ' ', entry.time, ' - ', entry.dest);
					continue;
				end;

				current_flight := flight_in(entry.flight, by_flight);
				if current_flight = -1 then
				begin
					setLength(by_flight, length(by_flight)+1);
					by_flight[length(by_flight)-1].flight := entry.flight;
					setLength(by_flight[length(by_flight)-1].passengers, 1);
					by_flight[length(by_flight)-1].passengers[0] := entry;
				end
				else
				begin
					setLength(by_flight[current_flight].passengers, length(by_flight[current_flight].passengers)+1);
					by_flight[current_flight].passengers[length(by_flight[current_flight].passengers)-1] := entry;
				end;
				sort(by_flight);
				writeln();
			end;

		'p':
			for flighter in by_flight do
			begin
				writeln('flight ', flighter.flight);
				for entry in flighter.passengers do
				begin
					writeln('    ', entry.flight, ' - ', entry.firstname, ' ', entry.patro, ' ', entry.surname, ' - ', entry.date, ' ', entry.time, ' - ', entry.dest);
				end;
			end;

		'q':
			begin
				writeln('quitting...');
				break;
			end;
		end;
	end;


end.