
module TopModule(
  output reg one
);

  always @(*) begin
    one = 1'b1; // Always drive 1 (logic high)
  end

endmodule