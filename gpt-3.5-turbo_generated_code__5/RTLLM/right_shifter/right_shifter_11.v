
module right_shifter (
  input clk,
  input d,
  output reg [7:0] q
);

  // Initialize q to 0
  initial begin
    q <= 8'b0;
  end

  // Shift the contents of q to the right by 1 bit and insert d at q[7]
  always @(posedge clk) begin
    q <= {d, q[7:1]};
  end

endmodule