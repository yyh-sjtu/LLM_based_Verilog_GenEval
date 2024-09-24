module count_slow (
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q
);
  parameter [3:0] MAX = 4'b0000;
  parameter [3:0] MIN = 4'b0000;
  parameter [3:0] MAX = 4'b0000;
  parameter [3:0] COUNT = 3'b0000;
  always @(posedge clk)
    if (reset)
      q <= 0;
    else if (slowena)
      q <= q + 1;
endmodule

