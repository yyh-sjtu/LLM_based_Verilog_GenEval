
module multi_pipe_8bit (
  input clk,
  input rst_n,
  input mul_en_in,
  input [7:0] mul_a,
  input [7:0] mul_b,
  output mul_en_out,
  output [15:0] mul_out
);

  reg mul_en_out_reg;
  reg [7:0] mul_a_reg;
  reg [7:0] mul_b_reg;
  reg [7:0] temp [7:0];
  reg [15:0] sum [7:0];
  reg [15:0] mul_out_reg;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      mul_en_out_reg <= 0;
      mul_a_reg <= 0;
      mul_b_reg <= 0;
      mul_out_reg <= 0;
      for (i = 0; i < 8; i = i + 1) begin
        temp[i] <= 0;
        sum[i] <= 0;
      end
    end else begin
      mul_en_out_reg <= mul_en_in;
      if (mul_en_in) begin
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;
      end
      for (i = 0; i < 8; i = i + 1) begin
        temp[i] <= mul_a_reg * mul_b_reg[i];
        if (i == 0) begin
          sum[i] <= temp[i];
        end else begin
          sum[i] <= sum[i-1] + temp[i];
        end
      end
      mul_out_reg <= sum[7];
    end
  end

  assign mul_en_out = mul_en_out_reg[7];
  assign mul_out = (mul_en_out_reg && !rst_n) ? mul_out_reg : 16'b0;

endmodule