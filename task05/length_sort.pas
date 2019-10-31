program length_sort;

uses
	SysUtils,
	Character;

type 
	part = record
	title : string;
	quantity : integer;
	price : double;
	end;

	char_file = file of char;

function read_word(var input_file : char_file) : string;
var
	buffer : char = char(10);
	output : string = '';
begin
	if eof(input_file) then
		exit(output);
	
	read(input_file, buffer);
	while (not isLetterOrDigit(buffer)) and (not eof(input_file)) do
		read(input_file, buffer);
	
	if eof(input_file) then
		exit(output);

	if buffer <> ';' then
		output := output + buffer;

	while (isLetterOrDigit(buffer)) and (not eof(input_file)) do
	begin
		read(input_file, buffer);
		if ((isLetterOrDigit(buffer)) and (buffer <> ';')) then
			output := output + buffer;
	end;

	exit(output);
end;

function comparator(left : string; right : string) : integer;
begin
	// writeln('comp: ', (left), '-', (right), '=', length(left) - length(right));
	exit (length(left) - length(right));
end;

procedure sort(var input : array of string; size : integer);
Var
	i, j : integer;
	buf : string = '';
begin
	// writeln(size);
	for i := 0 to size-1 do
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
	input : array [0..255] of string;
	counter : integer = 0;
	title : string = '';
	words_file : file of char;
begin

	writeln('enter filename:');

	{$I-}
	readln(title);
	{$I+}

	if (ioresult <> 0) or (title = '') then
	begin
		writeln('wrong filename');
		exit;
	end;

	{$I-}
	assign(words_file, title+'.bak');
	reset(words_file);
	{$I+}
	
	if (ioresult <> 0) then
	begin
		writeln('file "', title, '" not found or cannot be opened');
		exit;
	end;

	while true do
	begin
		input[counter] := read_word(words_file);
		if input[counter] = '' then
			break;

		counter := counter + 1;
	end;

	for title in input do
		if title <> '' then
			write(title, ' ');
	writeln(';');
	
	sort(input, counter);

	for title in input do
		if title <> '' then
			write(title, ' ');
	writeln(';');
	

end.