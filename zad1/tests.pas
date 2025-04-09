program RandomNumbersTests;

uses
  RandomNumbers;

procedure RunTest(testName: string; success: boolean);
begin
  if success then
    WriteLn(testName, ': PASSED')
  else
    WriteLn(testName, ': FAILED');
end;

{ Test 1: Verify array generation with correct count }
procedure TestArrayGenerationCount;
var
  nums: TNumberArray;
  testCount: Integer;
begin
  testCount := 5;
  InitArray(nums, testCount);
  RunTest('Array generation count', Length(nums) = testCount);
end;

{ Test 2: Verify numbers are within specified range }
procedure TestNumberRange;
var
  nums: TNumberArray;
  i, min, max: Integer;
  inRange: Boolean;
begin
  min := 10;
  max := 20;
  InitArray(nums, 50);
  GenerateNumbers(nums, min, max);
  
  inRange := True;
  for i := 0 to High(nums) do
    if (nums[i] < min) or (nums[i] > max) then
      inRange := False;
  
  RunTest('Number range validation', inRange);
end;

{ Test 3: Verify sorting of reverse-ordered array }
procedure TestSortReverseOrder;
var
  nums: TNumberArray;
begin
  InitArray(nums, 3);
  nums[0] := 3; nums[1] := 2; nums[2] := 1;
  BubbleSort(nums);
  RunTest('Sort reverse-ordered array', (nums[0] = 1) and (nums[1] = 2) and (nums[2] = 3));
end;

{ Test 4: Verify already sorted array remains sorted }
procedure TestAlreadySorted;
var
  nums: TNumberArray;
begin
  InitArray(nums, 4);
  nums[0] := 1; nums[1] := 2; nums[2] := 3; nums[3] := 4;
  BubbleSort(nums);
  RunTest('Already sorted array', IsSorted(nums));
end;

{ Test 5: Verify sorting with duplicate values }
procedure TestSortWithDuplicates;
var
  nums: TNumberArray;
begin
  InitArray(nums, 5);
  nums[0] := 2; nums[1] := 1; nums[2] := 2; nums[3] := 3; nums[4] := 1;
  BubbleSort(nums);
  RunTest('Sort with duplicates', IsSorted(nums));
end;

begin
  WriteLn('Running RandomNumbers unit tests...');
  WriteLn('---------------------------------');
  
  TestArrayGenerationCount;
  TestNumberRange;
  TestSortReverseOrder;
  TestAlreadySorted;
  TestSortWithDuplicates;
  
  WriteLn('---------------------------------');
  WriteLn('Tests completed');
end.