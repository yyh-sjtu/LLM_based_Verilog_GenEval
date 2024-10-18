
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output [31:0] out
);

  reg [31:0] out_reg;

  always @(posedge clk or posedge reset) begin
    if (reset)
      out_reg <= 0;
    else begin
      out_reg <= out_reg | (in & (~out_reg));
    end
  end

  assign out = out_reg;

endmodule