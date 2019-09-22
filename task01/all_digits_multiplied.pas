program all_digits_multiplied;
var
	number : integer = -1;
	count: integer = 1;
begin
	number := 0;
	count := 1;
	writeln('Введите число:');
	{$I-}
	readln(number);
	{$I+}

	if (ioresult <> 0) or (number < 0) then
	begin
		writeln('Неверный ввод');
		exit;
	end;
	
	if (number = 0) then
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

