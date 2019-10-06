// cos(x)=∏_(n)(1-4x^2/((2n-1)^2*pi^2))
program series;

// {$APPTYPE CONSOLE}

uses
	SysUtils,
	Math;
var
	result : double = 1.0;
	newresult : double = 1.0;
	n : integer = 1;
	x : double = 0.0;
	error : double = 0.0;
begin
	readln(x, error);
	// x := x * pi / 180;
	while true do
	begin
		newresult := result * (1 - ( 4*x*x/((2*n-1)*(2*n-1)*180*180) ) );
		if ((newresult - result) < error) and ((result - newresult) < error) then
		begin
			writeln(newresult);
			break;
		end;
		result := newresult;
		n := n + 1;
	end;
end.