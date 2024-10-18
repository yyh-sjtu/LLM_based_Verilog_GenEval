
module multi_pipe_8bit (
  input clk,
  input rst_n,
  input mul_en_in,
  input [7:0] mul_a,
  input [7:0] mul_b,
  output reg mul_en_out,
  output reg [15:0] mul_out
);

  // Input Registers
  reg [7:0] mul_a_reg;
  reg [7:0] mul_b_reg;

  // Partial Product Generation
  wire [7:0] temp [0:7];

  // Partial Sum Calculation
  reg [15:0] sum [0:7];

  // Final Product Calculation
  reg [15:0] mul_out_reg;

  // Input Control
  reg mul_en_out_reg;

  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 0) begin
      mul_a_reg <= 0;
      mul_b_reg <= 0;
      mul_en_out_reg <= 0;
    end else begin
      if (mul_en_in == 1) begin
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;
        mul_en_out_reg <= mul_en_in;
      end
    end
  end

  // Partial Product Generation
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin : partial_products
      assign temp[i] = mul_a_reg & mul_b_reg[i];
    end
  endgenerate

  // Partial Sum Calculation
  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 0) begin
      sum <= 0;
    end else begin
      sum[0] <= temp[0];
      sum[1] <= sum[0] + temp[1];
      sum[2] <= sum[1] + temp[2];
      sum[3] <= sum[2] + temp[3];
      sum[4] <= sum[3] + temp[4];
      sum[5] <= sum[4] + temp[5];
      sum[6] <= sum[5] + temp[6];
      sum[7] <= sum[6] + temp[7];
    end
  end

  // Final Product Calculation
  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 0) begin
      mul_out_reg <= 0;
    end else begin
      mul_out_reg <= sum[7];
    end
  end

  // Output Assignment
  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 0) begin
      mul_en_out <= 0;
      mul_out <= 0;
    end else begin
      mul_en_out <= mul_en_out_reg[7];
      if (mul_en_out == 1) begin
        mul_out <= mul_out_reg;
      end else begin
        mul_out <= 16'b0;
      end
    end
  end

endmodule