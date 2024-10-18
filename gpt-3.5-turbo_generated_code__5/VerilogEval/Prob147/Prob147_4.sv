
module TopModule (
    input clk,
    input a,
    input b,
    output q,
    output state
);

  reg q_reg;
  always @(posedge clk) begin
    if (a & ~b)
      q_reg <= 1;
    else if (~a & b)
      q_reg <= 0;
  end

  assign q = q_reg;
  assign state = q;

endmodule