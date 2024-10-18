
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
  
  always @(posedge clk) begin
    if (reset)
      q <= 4'b0001; // Reset to 1
    else if (q == 4'b1010) // Counter reaches 10
      q <= 4'b0001; // Reset to 1
    else
      q <= q + 1; // Increment counter
  end
  
endmodule