
module adder_pipe_64bit(
  input clk,
  input rst_n,
  input i_en,
  input [63:0] adda,
  input [63:0] addb,
  output reg [64:0] result,
  output reg o_en
);

  reg [63:0] stage0_sum;
  reg [63:0] stage1_sum;
  reg [63:0] stage2_sum;
  reg [63:0] stage3_sum;
  reg stage0_carry;
  reg stage1_carry;
  reg stage2_carry;

  // Pipeline stage 0
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      stage0_sum <= 0;
      stage0_carry <= 0;
    end else if (i_en) begin
      stage0_sum <= adda + addb;
      stage0_carry <= adda[63] & addb[63];
    end
  end

  // Pipeline stage 1
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      stage1_sum <= 0;
      stage1_carry <= 0;
    end else if (i_en) begin
      stage1_sum <= stage0_sum;
      stage1_carry <= stage0_carry;
    end
  end

  // Pipeline stage 2
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      stage2_sum <= 0;
      stage2_carry <= 0;
    end else if (i_en) begin
      stage2_sum <= stage1_sum;
      stage2_carry <= stage1_carry;
    end
  end

  // Pipeline stage 3
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      stage3_sum <= 0;
    end else if (i_en) begin
      stage3_sum <= stage2_sum;
    end
  end

  // Output stage
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result <= 0;
      o_en <= 0;
    end else if (i_en) begin
      result <= {stage3_sum, stage2_carry};
      o_en <= 1;
    end else begin
      result <= 0;
      o_en <= 0;
    end
  end

endmodule