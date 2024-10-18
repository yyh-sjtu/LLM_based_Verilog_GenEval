
module multi_pipe_8bit (
  input clk,
  input rst_n,
  input mul_en_in,
  input [7:0] mul_a,
  input [7:0] mul_b,
  output reg mul_en_out,
  output reg [15:0] mul_out
);

  reg [7:0] mul_a_reg;
  reg [7:0] mul_b_reg;
  reg [7:0] temp [7:0];
  reg [8:0] sum [6:0];
  reg [15:0] mul_out_reg;

  always @(posedge clk) begin
    if (~rst_n) begin
      mul_a_reg <= 8'b0;
      mul_b_reg <= 8'b0;
      mul_en_out <= 1'b0;
      mul_out_reg <= 16'b0;
      for (int i = 0; i < 8; i = i + 1)
        temp[i] <= 8'b0;
      for (int i = 0; i < 7; i = i + 1)
        sum[i] <= 9'b0;
    end else begin
      if (mul_en_in) begin
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;
      end
      for (int i = 0; i < 8; i = i + 1) begin
        if (mul_b_reg[i])
          temp[i] <= {mul_a_reg[7:0], 1'b0} >> i;
        else
          temp[i] <= 8'b0;
      end
      for (int i = 0; i < 7; i = i + 1)
        sum[i] <= sum[i] + temp[i];
      mul_out_reg <= {sum[6], sum[5:0]};
      mul_en_out <= sum[6];
    end
  end

  assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

endmodule