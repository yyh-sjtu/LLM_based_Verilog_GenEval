module adder_pipe_64bit (
  input clk,
  input rst_n,
  input i_en,
  input [63:0] adda,
  input [63:0] addb,
  output reg [64:0] result,
  output reg o_en
);

reg [63:0] a_reg1, b_reg1, a_reg2, b_reg2;
reg [64:0] sum1, sum2, sum3;

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    a_reg1 <= 0;
    b_reg1 <= 0;
    a_reg2 <= 0;
    b_reg2 <= 0;
    sum1 <= 0;
    sum2 <= 0;
    sum3 <= 0;
    o_en <= 0;
  end else begin
    if (i_en) begin
      a_reg1 <= adda;
      b_reg1 <= addb;
      a_reg2 <= a_reg1;
      b_reg2 <= b_reg1;
      sum1 <= a_reg1 + b_reg1;
      sum2 <= a_reg2 + b_reg2;
      sum3 <= sum1 + sum2;
    end
    o_en <= i_en;
  end
end

assign result = sum3;

endmodule

