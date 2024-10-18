
module TopModule (
  input  clk,
  input  a,
  output q
);

  reg q_reg;
  
  always @(posedge clk) begin
    if (a)
      q_reg <= 1'b1;
    else
      q_reg <= 1'b0;
  end
  
  assign q = q_reg;

endmodule