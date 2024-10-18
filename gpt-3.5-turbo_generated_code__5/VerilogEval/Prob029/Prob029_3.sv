
module TopModule (
  input in1,
  input in2,
  input in3,
  output out
);

  // Internal wire declaration
  wire w1;

  // XNOR gate implementation
  assign w1 = ~(in1 ^ in2);

  // XOR gate implementation
  assign out = w1 ^ in3;

endmodule