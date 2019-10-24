program neighbours;

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

var
	input : array [0..49] of string;
	i : integer = 0;
	iter_word : string;
begin
	writeln('enter text');
	while (i < 50) and not eof() do
	begin
		input[i] := read_word();
		i := i + 1;
	end;

	writeln('INPUT:');
	for iter_word in input do
		if iter_word <> '' then
			writeln(iter_word);
	
	writeln('OUTPUT:');
	
	// for i:=1 to 48 do
	// 	if input[i] <> '' then
	// 		writeln(input[i]);

	i := 1;
	while i < 49 do
	begin
		// if ((integer(CompareText(input[i], '')) <> 0) and (integer(CompareText(input[i], input[i-1])) = 0) and (integer(CompareText(input[i], input[i+1])) = 0)) then
		if (input[i] <> '') and (input[i+1] = input[i-1]) then
			writeln(input[i-1]);
		i := i + 1;
	end;
end.