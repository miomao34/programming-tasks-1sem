program list;

uses
	SysUtils,
	Character;


type 
detail = record
   detail_name : string;
   quantity : integer;
   place : string;
end;

detail_array = array of detail;

detail_hash = record
	detail_name : string;
	details : detail_array;
end;

detail_hash_array = array of detail_hash;


function detail_hash_in(detail_name : string; var detail_hashes : detail_hash_array) : integer;
var
	i : integer;
begin
	for i := 0 to length(detail_hashes)-1 do
	begin
		if detail_hashes[i].detail_name = detail_name then
			exit(i);
	end;
	exit(-1);
end;


function comparator(left : detail; right : detail) : integer;
begin
	exit(left.quantity - right.quantity);
end;

procedure sort(var input : detail_array);
Var
	i, j : integer;
	buf : detail;
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
	input : detail_array;
	by_name : detail_hash_array;
	detail_hashr : detail_hash;
	title : string;
	find_place : string;
	found : boolean;
	selector : char;
	database_file : file of detail;
	entry : detail;
	i : integer;
	j : integer;
	current_detail_hash : integer = 0;
	label another_file;
begin

another_file:
	writeln('enter database filename:');
	readln(title);

	assign(database_file, title);
	reset(database_file);

	writeln('opened ', title);

	setLength(input, 0);
	setLength(by_name, 0);

	while not eof(database_file) do
	begin
		setLength(input, length(input)+1);
		read(database_file, input[length(input) - 1]);
	end;

	close(database_file);

	for i := 0 to length(input)-1 do
	begin
		entry := input[i];
		current_detail_hash := detail_hash_in(entry.detail_name, by_name);
		if current_detail_hash = -1 then
		begin
			setLength(by_name, length(by_name)+1);
			by_name[length(by_name)-1].detail_name := entry.detail_name;
			setLength(by_name[length(by_name)-1].details, 1);
			by_name[length(by_name)-1].details[0] := entry;
		end
		else
		begin
			setLength(by_name[current_detail_hash].details, length(by_name[current_detail_hash].details)+1);
			by_name[current_detail_hash].details[length(by_name[current_detail_hash].details)-1] := entry;
		end;
	end;
	
	for i:=0 to length(by_name)-1 do
	begin
		writeln('detail ', by_name[i].detail_name);
		for j:=0 to length(by_name[i].details)-1 do
		begin
			writeln('    ', by_name[i].details[j].detail_name, ' - ', by_name[i].details[j].place, ' - ', by_name[i].details[j].quantity);
		end;
	end;
	
	for i:=0 to length(by_name)-1 do
		sort(by_name[i].details);
	writeln('sorted input');
	
	for i:=0 to length(by_name)-1 do
	begin
		writeln('detail ', by_name[i].detail_name);
		for j:=0 to length(by_name[i].details)-1 do
		begin
			writeln('    ', by_name[i].details[j].detail_name, ' - ', by_name[i].details[j].place, ' - ', by_name[i].details[j].quantity);
		end;
	end;

	
	while true do
	begin
		writeln('1 - write table out');
		writeln('2 - insert new detail');
		writeln('3 - find all details in place');
		writeln('4 - load another file');
		writeln('5 - show all detail names');
		writeln('6 - show all details of one name');
		writeln('7 - show all details');
		writeln('8 - exit');
		writeln();
		readln(selector);

		case selector of
		'1':
			begin
				writeln('enter database filename:');
				readln(title);

				assign(database_file, title);
				rewrite(database_file);

				for i := 0 to length(by_name)-1 do
					for j := 0 to length(by_name[i].details)-1 do
					begin
						write(database_file, by_name[i].details[j]);
					end;
				writeln('written');
			end;
		
		'2':
			begin
				writeln('enter new detail:');
				writeln('[detail_name] <ENTER> [quantity] <ENTER> [place] <ENTER>');
				readln(entry.detail_name);
				readln(entry.quantity);
				readln(entry.place);

				current_detail_hash := detail_hash_in(entry.detail_name, by_name);
				if current_detail_hash = -1 then
				begin
					setLength(by_name, length(by_name)+1);
					by_name[length(by_name)-1].detail_name := entry.detail_name;
					setLength(by_name[length(by_name)-1].details, 1);
					by_name[length(by_name)-1].details[0] := entry;
				end
				else
				begin
					setLength(by_name[current_detail_hash].details, length(by_name[current_detail_hash].details)+1);
					by_name[current_detail_hash].details[length(by_name[current_detail_hash].details)-1] := entry;
				end;

				for i:=0 to length(by_name)-1 do
					sort(by_name[i].details);

				writeln();
				
				for i:=0 to length(by_name)-1 do
					sort(by_name[i].details);

				writeln();
			end;

		'3':
			begin
				writeln('enter place:');
				readln(find_place);

				found := false;

				for i:=0 to length(by_name) do
				begin
					for j:=0 to length(by_name[i].details)-1 do
					begin
						if tolower(by_name[i].details[j].place) = tolower(find_place) then
						begin
							writeln('    ', by_name[i].details[j].detail_name, ' - ', by_name[i].details[j].place, ' - ', by_name[i].details[j].quantity);
							found := true;
						end;
					end;
				end;
				if not found then
					writeln('detail not found');
				writeln();
			end;

		'4':	goto another_file;
			
		'5':
			begin
				for i := 0 to length(by_name)-1 do
					writeln(by_name[i].detail_name);
				writeln();
			end;

		'6':
			begin
				writeln('enter detail name:');
				readln(find_place);
				current_detail_hash := detail_hash_in(find_place, by_name);
				if current_detail_hash = -1 then
				begin
					writeln('detail not found');
					continue;
				end;

				for i := 0 to length(by_name[current_detail_hash].details)-1 do
				begin
					entry := by_name[current_detail_hash].details[i];
					writeln('    ', entry.detail_name, ' - ', entry.quantity, ' - ', entry.place);
				end;
				writeln();
			end;

		'7':
			for i:=0 to length(by_name)-1 do
			begin
				writeln('detail ', by_name[i].detail_name);
				for j:=0 to length(by_name[i].details)-1 do
				begin
					writeln('    ', by_name[i].details[j].detail_name, ' - ', by_name[i].details[j].place, ' - ', by_name[i].details[j].quantity);
				end;
			end;

		'8':
			begin
				writeln('quitting...');
				break;
			end;
		end;
	end;


end.