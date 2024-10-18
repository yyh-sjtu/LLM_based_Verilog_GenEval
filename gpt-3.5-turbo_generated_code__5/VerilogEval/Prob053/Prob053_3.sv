
module TopModule(
  input  wire clk,
  input  wire in,
  output wire out
);

  reg flipflop_d;
  wire xor_out;
  
  assign xor_out = in ^ flipflop_d;
  
  always @(posedge clk)
    flipflop_d <= xor_out;
  
  assign out = flipflop_d;

endmodule