
module counter_12 (
  input rst_n,
  input clk,
  input valid_count,
  output reg [3:0] out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)   // Reset signal is active low
      out <= 4'b0000;
    else if (valid_count) begin
      if (out == 4'd11)
        out <= 4'b0000;   // Counter wraps around and resets to 0
      else
        out <= out + 1;   // Increment counter
    end
  end

endmodule