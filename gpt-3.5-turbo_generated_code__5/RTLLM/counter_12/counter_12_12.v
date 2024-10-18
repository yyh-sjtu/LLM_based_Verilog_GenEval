
module counter_12 (rst_n, clk, valid_count, out);
  input rst_n; // Reset signal (active low)
  input clk; // Clock signal
  input valid_count; // Signal to enable counting
  output reg [3:0] out; // 4-bit output representing the current count value

  always @(posedge clk, negedge rst_n)
  begin
    if (!rst_n) // Reset condition
      out <= 4'b0000;
    else if (valid_count && (out == 4'd11)) // Increment and wrap around
      out <= 4'b0000;
    else if (valid_count) // Increment
      out <= out + 1;
  end
endmodule