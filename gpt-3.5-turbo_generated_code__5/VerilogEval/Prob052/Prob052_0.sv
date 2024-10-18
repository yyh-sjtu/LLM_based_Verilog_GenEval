
module TopModule(
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);
  wire [99:0] invert_in;
  
  // Invert all the input bits
  // This is needed to calculate XOR output
  assign invert_in = ~in;
  
  // Implement 100-input AND gate
  assign out_and = &in;
  
  // Implement 100-input OR gate
  assign out_or = |in;
  
  // Implement 100-input XOR gate
  assign out_xor = ^invert_in;
  
endmodule