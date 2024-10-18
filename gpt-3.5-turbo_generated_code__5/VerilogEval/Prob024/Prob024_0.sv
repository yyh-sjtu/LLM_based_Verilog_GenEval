
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);

  // Use XOR gate for sum
  assign sum = a ^ b;

  // Use AND gate for carry-out
  assign cout = a & b;
  
endmodule