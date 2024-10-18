
module TopModule (
  input  clk,
  input  a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a)
      q <= ((q + 3) % 8);
  end

endmodule