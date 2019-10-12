program series;

uses
	SysUtils,
	Math;
var
	hash_table : array[' '..'~'] of boolean;
	input : string = '';
	partial_input : string = '';
	input_saved : string = '';
	i : char;
	position : integer = -1;

function delete_char_in_string(input : string; letter : char): string;
var
	output : string = '';
	position : integer = -1;
begin
	output := input;
	position := pos(letter, input);
	while position > 0 do
	begin
		delete(output, position, 1);
		position := pos(letter, output);
	end;

	exit(output);
end;

begin
	writeln('enter string');
	{$I-}
	readln(input);
	{$I+}

	if (ioresult <> 0) or (input = '') then
	begin
		writeln('wrong input');
		exit;
	end;
	input := lowercase(input);
	input_saved := input;

	for i:=' ' to '~' do
	begin
		position := pos(i, input);
		if position > 0 then
		begin
			partial_input := copy(input, position+1, length(input));
			partial_input := delete_char_in_string(partial_input, i);
			delete(input, position+1, length(input));
			input := input + partial_input;
		end;
	end;

	writeln(input_saved);
	writeln(input);
end.