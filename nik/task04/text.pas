program text;

uses
	SysUtils,
	Character;

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

function has_dupl_first_char(input : string) : boolean;
var
	first_char, letter : char;
begin
	first_char := input[1];

	for letter in copy(input, 2, length(input)) do
	begin
		if letter = first_char then
			exit(true);
	end;

	exit(false);
end;

var
	input : array [0..49] of string;
	i : integer = 0;
	word : string;
begin
	writeln('enter text');
	while (i < 50) and not eof() do
	begin
		input[i] := read_word();
		// writeln('* ', input[i], ':', has_dupl_first_char(input[i]));
		i := i + 1;
	end;

	writeln('INPUT:');
	for word in input do
		if word <> '' then
			writeln(word);
	
	writeln('OUTPUT:');
	for word in input do
		if has_dupl_first_char(word) then
			writeln(word);

end.