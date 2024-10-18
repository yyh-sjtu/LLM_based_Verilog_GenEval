
module TopModule(
  input clk,
  input reset,
  input slowena,
  output reg [3:0] q
);

  always @(posedge clk, posedge reset) begin
    if (reset)
      q <= 4'b0;
    else if (slowena)
      q <= q + 1;
  end

endmodule