program RandomNumbersProgram;

uses
  RandomNumbers;

const
  NUM_COUNT = 10;    // Change these values as needed
  MIN_VALUE = 0;    // Minimum random value
  MAX_VALUE = 100;    // Maximum random value

var
  MyNumbers: TNumberArray;
begin
  // Initialize and generate numbers
  InitArray(MyNumbers, NUM_COUNT);
  GenerateNumbers(MyNumbers, MIN_VALUE, MAX_VALUE);

  // Display results
  Writeln('Generated ', NUM_COUNT, ' numbers (', MIN_VALUE, '-', MAX_VALUE, ')');
  Write('Unsorted: ');
  DisplayList(MyNumbers);

  // Sort and display
  BubbleSort(MyNumbers);
  Write('Sorted:   ');
  DisplayList(MyNumbers);
end.