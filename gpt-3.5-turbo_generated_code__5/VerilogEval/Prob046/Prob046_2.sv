
module TopModule (
  input clk,
  input reset,
  input [7:0] d,
  output [7:0] q
);

  reg [7:0] q_reg;

  always @(negedge clk) begin
    if (reset)
      q_reg <= 8'b00110100; // Reset value is 0x34
    else
      q_reg <= d;
  end

  assign q = q_reg;

endmodule