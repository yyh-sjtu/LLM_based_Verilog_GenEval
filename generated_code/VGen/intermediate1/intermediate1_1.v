
module half_adder(
  input a, b,
  output cout, sum
);

  // Output signals
  assign sum = a ^ b; // XOR gate implementation for sum
  assign cout = a & b; // AND gate implementation for carry out

endmodule