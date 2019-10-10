// cos(x)=∏_(n)(1-4x^2/((2n-1)^2*pi^2))
program series;

// {$APPTYPE CONSOLE}

uses
	SysUtils,
	Math;
var
	newresult : double = 1.0;
	result : double = 1.0;
	n : int64 = 1;
	x : double = 0.0;
	error : double = 1.1;
begin
	writeln('cos(x): enter x and error');
	{$I-}
	readln(x, error);
	{$I+}

	if (ioresult <> 0) or (error < 0.0000000001) then
	begin
		writeln('wrong input');
		exit;
	end;
	
	// writeln(cos(x*pi/180):0:20);
	while true do
	begin
		newresult := result * (1 - ( 4*x*x/((2*n-1)*(2*n-1)*180*180) ) );
		if ((newresult - result) < (error / n)) and ((result - newresult) < (error / n)) then
		begin
			writeln(newresult:0:20);
			break;
		end;
		result := newresult;
		n := n + 1;
	end;
end.