
module TopModule(
  input clock,
  input a,
  output p,
  output q
);
  reg p_reg;
  reg q_reg;
  reg q_reg_prev;

  always @(posedge clock) begin
    p_reg <= a;
    q_reg_prev <= q_reg;
    q_reg <= (clock & ~a) | (q_reg_prev & ~clock);
  end

  assign p = p_reg;
  assign q = q_reg;
endmodule