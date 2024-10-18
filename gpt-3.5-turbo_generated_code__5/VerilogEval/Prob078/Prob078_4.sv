
module TopModule(
  input  clk,
  input  d,
  output q
);
  reg q1, q2;

  always @(posedge clk) begin
    q1 <= d;
    q2 <= q1;
  end

  always @(negedge clk) begin
    q1 <= q2;
  end

  assign q = q2;

endmodule