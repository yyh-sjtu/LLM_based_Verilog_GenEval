
module TopModule(
  input clk,
  input d,
  input r,
  output reg q
); 

  always @(posedge clk) begin
    if (r)     // Active high synchronous reset
      q <= 0;
    else
      q <= d;
  end

endmodule