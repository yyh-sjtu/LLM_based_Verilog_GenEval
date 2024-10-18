
module TopModule(
  input  clk,
  input  x,
  output z
);
  reg flipflop1;
  reg flipflop2;
  reg flipflop3;
  wire flipflop2_comp;
  wire flipflop3_comp;
  
  assign flipflop2_comp = ~flipflop2;
  assign flipflop3_comp = ~flipflop3;
  
  always @(posedge clk) begin
    flipflop1 <= x ^ flipflop1;
    flipflop2 <= x & flipflop2_comp;
    flipflop3 <= x | flipflop3_comp;
  end
  
  assign z = flipflop1 ^ flipflop2 ^ flipflop3;
  
endmodule