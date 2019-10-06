// cos(x)=∏_(n)(1-4x^2/((2n-1)^2*pi^2))
program series;

// {$APPTYPE CONSOLE}

uses
	SysUtils,
	Math;
var
	real_result : double = 1.0;
	result : double = 1.0;
	n : integer = 1;
	x : double = 0.0;
	error : double = 1.1;
begin
	writeln('cos(x): enter x and error');
	{$I-}
	readln(x, error);
	{$I+}

	if (ioresult <> 0) or (error < 0.0000000001)then
	begin
		writeln('wrong input');
		exit;
	end;

	real_result := cos(x*pi/180);

	while true do
	begin
		result := result * (1 - ( 4*x*x/((2*n-1)*(2*n-1)*180*180) ) );
		if ((result - real_result) < error) and ((real_result - result) < error) then
		begin
			writeln(result:0:20);
			break;
		end;
		n := n + 1;
	end;
end.