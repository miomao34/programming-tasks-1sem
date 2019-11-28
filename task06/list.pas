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


function newNode(payload : string) : nodeptr;
var
	ptr : nodeptr;
begin
	ptr := new(nodeptr);

	ptr^.payload := payload;
	ptr^.next := nil;

	exit(ptr);
end;

function deleteNext(ptr : nodeptr) : boolean;
var deletePtr : nodeptr;
begin
	if (ptr = nil) then
		exit(false);

	if (ptr^.next = nil) then
		exit(false);
	
	deletePtr := ptr^.next;
	if ptr^.next <> nil then
		ptr^.next := ptr^.next^.next;
	dispose(deletePtr);

	exit(true);
end;

function purgeDuplicates(ptr : nodeptr) : integer;
var 
	number : integer = 1;
	prev : nodeptr;
begin
	prev := ptr;
	while prev <> nil do
	begin
		if prev^.next = nil then
			exit(number);
		
		if prev^.next^.payload = ptr^.payload then
		begin
			deleteNext(prev);
			number := number + 1;
		end;

		prev := prev^.next;
	end;

	exit(number);
end;


var
	input : array of string;
	head : nodeptr;
	prev : nodeptr;
	i : integer = 0;
	counter : integer = 0;
begin
	while not eof() do
	begin
		setLength(input, length(input)+1);
		input[length(input) - 1] := read_word();
		if input[length(input) - 1] = '' then
			break;		
	end;

	head := newNode(input[0]);
	prev := head;
	i := 1;
	while ( i <= length(input) - 1) do
	begin
		prev^.next := newNode(input[i]);
		prev := prev^.next;
		i := i + 1;
	end;

	prev := head;
	while prev <> nil do
	begin
		writeln(prev^.payload);
		prev := prev^.next;
	end;
	
	prev := head;
	while prev <> nil do
	begin
		writeln('node: ', prev^.payload, ' - ', purgeDuplicates(prev));
		prev := prev^.next;
	end;

end.