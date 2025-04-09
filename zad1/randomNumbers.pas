unit RandomNumbers;

interface

type
  TNumberArray = array of Integer;

procedure InitArray(var numbers: TNumberArray; count: Integer);
procedure GenerateNumbers(var numbers: TNumberArray; minVal, maxVal: Integer);
procedure BubbleSort(var numbers: TNumberArray);
function IsSorted(numbers: TNumberArray): Boolean;
procedure DisplayList(numbers: TNumberArray);

implementation

procedure InitArray(var numbers: TNumberArray; count: Integer);
begin
  SetLength(numbers, count);
end;

procedure GenerateNumbers(var numbers: TNumberArray; minVal, maxVal: Integer);
var
  i: Integer;
begin
  Randomize;
  for i := 0 to High(numbers) do
    numbers[i] := Random(maxVal - minVal + 1) + minVal;
end;

procedure BubbleSort(var numbers: TNumberArray);
var
  i, j, temp: Integer;
begin
  for i := 0 to High(numbers) - 1 do
    for j := 0 to High(numbers) - i - 1 do
      if numbers[j] > numbers[j + 1] then
      begin
        temp := numbers[j];
        numbers[j] := numbers[j + 1];
        numbers[j + 1] := temp;
      end;
end;

function IsSorted(numbers: TNumberArray): Boolean;
var
  i: Integer;
begin
  IsSorted := True;
  for i := 0 to High(numbers) - 1 do
    if numbers[i] > numbers[i + 1] then
    begin
      IsSorted := False;
      Exit;
    end;
end;

procedure DisplayList(numbers: TNumberArray);
var
  i: Integer;
begin
  for i := 0 to High(numbers) do
  begin
    Write(numbers[i]);
    if i < High(numbers) then Write(', ');
  end;
  WriteLn;
end;

end.