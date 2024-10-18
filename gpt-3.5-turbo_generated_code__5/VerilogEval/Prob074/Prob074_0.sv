
module TopModule(
  input clk,
  input x,
  output reg z
);

  reg d_flipflop_x;
  reg d_flipflop_y;
  reg d_flipflop_z;
  
  always @(posedge clk) begin
    d_flipflop_x <= x ^ d_flipflop_x;
    d_flipflop_y <= ~d_flipflop_x;
    d_flipflop_z <= d_flipflop_x;
    
    z <= ~(d_flipflop_x ^ d_flipflop_y ^ d_flipflop_z);
  end

endmodule