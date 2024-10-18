
module multi_pipe_8bit (
  input clk,
  input rst_n,
  input mul_en_in,
  input [7:0] mul_a,
  input [7:0] mul_b,
  output reg mul_en_out,
  output reg [15:0] mul_out
);

  reg [7:0] mul_en_out_reg;
  reg [7:0] mul_a_reg;
  reg [7:0] mul_b_reg;

  wire [7:0] temp[7:0];
  reg [15:0] sum[7:0];
  reg [15:0] mul_out_reg;

  always @(posedge clk) begin
    if (~rst_n) begin
      mul_en_out_reg <= 0;
      mul_a_reg <= 0;
      mul_b_reg <= 0;
      mul_out_reg <= 0;
    end else begin
      mul_en_out_reg <= mul_en_in;
      
      if (mul_en_in) begin
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;
      end
    end
  end

  assign temp[7] = mul_b_reg[7] ? mul_a_reg : 0;
  assign temp[6] = mul_b_reg[6] ? mul_a_reg : 0;
  assign temp[5] = mul_b_reg[5] ? mul_a_reg : 0;
  assign temp[4] = mul_b_reg[4] ? mul_a_reg : 0;
  assign temp[3] = mul_b_reg[3] ? mul_a_reg : 0;
  assign temp[2] = mul_b_reg[2] ? mul_a_reg : 0;
  assign temp[1] = mul_b_reg[1] ? mul_a_reg : 0;
  assign temp[0] = mul_b_reg[0] ? mul_a_reg : 0;

  always @(posedge clk) begin
    if (~rst_n) begin
      sum[7] <= 0;
      sum[6] <= 0;
      sum[5] <= 0;
      sum[4] <= 0;
      sum[3] <= 0;
      sum[2] <= 0;
      sum[1] <= 0;
      sum[0] <= 0;
    end else begin
      if (mul_en_in) begin
        sum[7] <= (mul_b_reg[7] ? mul_a_reg : 0) + sum[6];
        sum[6] <= (mul_b_reg[6] ? mul_a_reg : 0) + sum[5];
        sum[5] <= (mul_b_reg[5] ? mul_a_reg : 0) + sum[4];
        sum[4] <= (mul_b_reg[4] ? mul_a_reg : 0) + sum[3];
        sum[3] <= (mul_b_reg[3] ? mul_a_reg : 0) + sum[2];
        sum[2] <= (mul_b_reg[2] ? mul_a_reg : 0) + sum[1];
        sum[1] <= (mul_b_reg[1] ? mul_a_reg : 0) + sum[0];
        sum[0] <= (mul_b_reg[0] ? mul_a_reg : 0);
        mul_out_reg <= sum[7];
      end
    end
  end

  always @(*) begin
    if (mul_en_out_reg[7]) begin
      mul_out <= mul_out_reg;
    end else begin
      mul_out <= 0;
    end
  end

  always @(posedge clk) begin
    if (~rst_n) begin
      mul_en_out <= 0;
    end else begin
      mul_en_out <= mul_en_out_reg[7];
    end
  end

endmodule