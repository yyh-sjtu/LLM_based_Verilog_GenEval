
module TopModule(
  input clk,
  input reset,
  input [7:0] d,
  output reg [7:0] q
);

  // Create an internal signal to hold the reset value
  reg [7:0] reset_value = 8'h34;

  // Create 8 D flip-flops with synchronous reset
  always @(negedge clk) begin
    if (reset)
      q <= reset_value;
    else
      q <= d;
  end

endmodule