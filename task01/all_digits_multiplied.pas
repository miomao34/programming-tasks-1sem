program all_digits_multiplied;
var
	number : integer = -1;
	count: integer = 1;
begin
	number := 0;
	count := 1;
	writeln('Введите число:');
	readln(number);
	
	if (number < 0) then
	begin
		writeln('Отрицательное число');
		exit;
	end
	else if (number = 0) then
		begin
			writeln('Результат: 0');
			exit;
		end;
	
	while(number > 0) do
	begin
		count := count * (number mod 10);
		number := number div 10;
	end;
	
	writeln('Результат: ', count);
end.

