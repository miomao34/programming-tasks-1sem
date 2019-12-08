program list;

uses
	SysUtils,
	Character;

type 
	node = record
		payload : string;
		next : ^node;
	end;

	nodeptr = ^node;


procedure swapNexts(ptr1_prev, ptr1_swap, ptr2_prev, ptr2_swap : nodeptr);
var buffer : nodeptr;
begin
	if ptr1_prev <> nil then
	begin
		ptr1_prev^.next := ptr2_swap;
		
	end;
	if ptr2_prev <> nil then
		ptr2_prev^.next := ptr1_swap;
	
	buffer := ptr1_swap^.next;
	ptr1_swap^.next := ptr2_swap^.next;
	ptr2_swap^.next := buffer;
end;

var
	input : array of string;
	head : nodeptr;
	prev : nodeptr;
	buf : nodeptr;
	swap_prev : nodeptr;
	swap : nodeptr;
	counter : integer = 0;
	i : integer = 0;
	j : integer = 0;
begin
	while not eof() do
	begin
		setLength(input, length(input)+1);
		readln(input[length(input)-1]);
		if input[length(input) - 1] = '' then
			break;
	end;

	head := new(nodeptr);
	head^.payload := input[counter];
	prev := head;
	counter := 1;
	while ( counter <= length(input) - 1) do
	begin
		prev^.next := new(nodeptr);
		prev^.next^.payload := input[counter];
		prev := prev^.next;
		counter := counter + 1;
	end;

	prev := head;
	counter := 1;
	while prev <> nil do
	begin
		writeln(counter, ' ', prev^.payload);
		counter := counter + 1;
		prev := prev^.next;
	end;

	writeln('enter i and j:');
	readln(i, j);
	writeln();

	prev := head;
	counter := 1;
	while prev <> nil do
	begin
		if counter = i-1 then 
		begin
			// writeln('boop ', prev^.payload);
			swap_prev := prev;
			swap := prev^.next;
			break;
		end;
		counter := counter + 1;
		prev := prev^.next;
	end;

	if i = 1 then
	begin
		swap_prev := nil;
		swap := head;
	end;

	prev := head;
	counter := 1;
	while prev <> nil do
	begin
		if counter = j-1 then 
		begin
			// writeln('beep ', prev^.payload);
			buf := prev^.next;
			swapNexts(swap_prev, swap, prev, prev^.next);
			if i = 1 then
				head := buf;	
			break;
		end;
		counter := counter + 1;
		prev := prev^.next;
	end;

	if j = 1 then
	begin
		swapNexts(swap_prev, swap, nil, head);
		head := swap;
	end;
	
	prev := head;
	counter := 1;
	while prev <> nil do
	begin
		writeln(counter, ' ', prev^.payload);
		counter := counter + 1;
		prev := prev^.next;
	end;

end.