
module TopModule (
  input  clk,
  input  d,
  input  r,
  output q
);

  reg q;

  always @(posedge clk) begin
    if (r == 1'b1) // Synchronous reset
      q <= 1'b0;
    else
      q <= d;
  end

endmodule