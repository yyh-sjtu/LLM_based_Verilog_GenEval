
module TopModule(
  input in1,
  input in2,
  input in3,
  output out
);
  
  // Instantiate XNOR gate
  wire xnor_out;
  assign xnor_out = in1 ^ in2;
  
  // Instantiate XOR gate
  wire xor_out;
  assign xor_out = xnor_out ^ in3;
  
  // Output
  assign out = xor_out;

endmodule