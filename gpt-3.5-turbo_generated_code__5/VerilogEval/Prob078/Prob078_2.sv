
module TopModule(
  input clk,
  input d,
  output q
);

  reg q_ff;
  reg q_tmp;

  always @(posedge clk) begin
    q_tmp <= d;
  end

  always @(posedge clk) begin
    q_ff <= q_tmp;
  end

  assign q = q_ff;

endmodule