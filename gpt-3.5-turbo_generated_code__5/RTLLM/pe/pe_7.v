
module pe (
  input clk,
  input rst,
  input [31:0] a,
  input [31:0] b,
  output reg [31:0] c
);

  always @(posedge clk or posedge rst) begin
    if (rst) // Reset condition
      c <= 0;
    else // Accumulate the result
      c <= c + (a * b);
  end

endmodule