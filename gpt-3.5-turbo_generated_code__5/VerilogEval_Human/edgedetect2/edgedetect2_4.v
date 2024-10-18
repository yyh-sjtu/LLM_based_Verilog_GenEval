
module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

  reg [7:0] prev_in; // Store previous input value

  always @(posedge clk) begin
    prev_in <= in; // Store current input value

    for (integer i = 0; i < 8; i = i + 1) begin
      if (in[i] && !prev_in[i]) // Detect rising edge
        anyedge[i] <= 1'b1; // Set output bit in the next cycle
      else
        anyedge[i] <= 1'b0; // Reset output bit
    end
  end

endmodule