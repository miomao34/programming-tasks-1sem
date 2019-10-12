program series;

uses
	SysUtils;
var
	input : string = '';
	output : string = '';
	i : char;
	position : integer = -1;
begin
	writeln('enter string');
	readln(input);

	if (input = '') then
	begin
		writeln('wrong input');
		exit;
	end;

	for i := 'a' to 'z' do
	begin
		position := pos(i, input);
		while position > 0 do
		begin
			output := output + i;
			delete(input, position, 1);
			position := pos(i, input);
		end;
	end;

	writeln(output);
end.