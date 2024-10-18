
module TopModule(
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  // Declaration of intermediate wires
  wire [3:0] and_inputs;
  wire [3:0] or_inputs;

  // AND gate implementation
  assign out_and = &and_inputs;
  assign and_inputs = in;

  // OR gate implementation
  assign out_or = |or_inputs;
  assign or_inputs = in;

  // XOR gate implementation
  assign out_xor = ^in;

endmodule