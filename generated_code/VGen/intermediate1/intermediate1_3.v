module

module half_adder(
  input a,
  input b,
  output cout,
  output sum
);

  assign sum = a ^ b; // XOR operation to calculate sum
  assign cout = a & b; // AND operation to calculate carry out

endmodule

