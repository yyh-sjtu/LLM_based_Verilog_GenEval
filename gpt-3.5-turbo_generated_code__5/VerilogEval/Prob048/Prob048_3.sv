
module TopModule (
  input clk,
  input d,
  input r,
  output reg q
);

  always @(posedge clk) begin
    if (r == 1'b1)      // Active high synchronous reset
      q <= 1'b0;
    else
      q <= d;
  end

endmodule