
module multi_pipe_8bit (
  input clk,
  input rst_n,
  input mul_en_in,
  input [7:0] mul_a,
  input [7:0] mul_b,
  output reg mul_en_out,
  output reg [15:0] mul_out
);

  // Input registers
  reg [7:0] mul_a_reg;
  reg [7:0] mul_b_reg;

  // Partial product generation
  wire [7:0] temp [7:0];

  // Partial sum calculation
  reg [15:0] sum [7:0];

  // Final product calculation
  reg [15:0] mul_out_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Reset signals
      mul_a_reg <= 8'd0;
      mul_b_reg <= 8'd0;
      mul_en_out <= 1'b0;
      mul_out_reg <= 16'd0;
      for (int i = 0; i < 8; i=i+1) begin
        sum[i] <= 16'd0;
        temp[i] <= 8'd0;
      end
    end
    else begin
      // Input register update
      if (mul_en_in) begin
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;
      end

      // Partial product generation
      for (int i = 0; i < 8; i=i+1) begin
        if (mul_b_reg[i]) begin
          temp[i] <= mul_a_reg << i;
        end
        else begin
          temp[i] <= 8'd0;
        end
      end

      // Partial sum calculation
      for (int i = 0; i < 8; i=i+1) begin
        if (i == 0) begin
          sum[i] <= temp[i];
        end
        else begin
          sum[i] <= sum[i-1] + temp[i];
        end
      end

      // Final product calculation
      mul_out_reg <= sum[7];

      // Output assignment
      if (mul_en_out) begin
        mul_out <= mul_out_reg;
      else begin
        mul_out <= 16'd0;
      end
    end
  end
endmodule