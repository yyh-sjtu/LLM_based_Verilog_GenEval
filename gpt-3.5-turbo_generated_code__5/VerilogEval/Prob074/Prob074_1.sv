
module TopModule (
  input  clk,
  input  x,
  output reg z
);

reg d1, d2, d3;

always @(posedge clk) begin
  d1 <= x ^ d1;
  d2 <= ~d1;
  d3 <= x | d3;
  z <= ~(d1 & d2 & d3);
end

endmodule