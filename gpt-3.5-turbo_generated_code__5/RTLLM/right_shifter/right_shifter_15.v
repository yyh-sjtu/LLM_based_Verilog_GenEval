
module right_shifter (
  input clk,
  input d,
  output reg [7:0] q
);

  initial begin
    q <= 8'b0;
  end

  always @(posedge clk) begin
    q <= (q >> 1);
    q[7] <= d;
  end

endmodule