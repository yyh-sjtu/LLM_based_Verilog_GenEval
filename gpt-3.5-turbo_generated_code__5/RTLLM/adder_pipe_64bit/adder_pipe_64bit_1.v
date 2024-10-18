
module adder_pipe_64bit (
  input clk,        // Clock input
  input rst_n,      // Active low reset signal
  input i_en,       // Enable signal for addition operation
  input [63:0] adda, // 64-bit input operand A
  input [63:0] addb, // 64-bit input operand B
  output [64:0] result, // 65-bit output representing the sum of adda and addb
  output o_en      // Output enable signal
  );

  wire [63:0] sum_result [2:0]; // Pipeline stages for sum results
  wire [63:0] carry [3:0];       // Carry signals for each stage
  wire [3:0] en_pipeline [3:0];  // Pipeline stages for enable signal

  // Stage 1
  assign sum_result[0] = adda + addb;
  assign carry[0] = (adda[0] & addb[0]) | (adda[0] & carry[0]) | (addb[0] & carry[0]);

  // Stage 2
  assign sum_result[1] = sum_result[0] + {carry[0], adda[1:0], addb[1:0]};
  assign carry[1] = (adda[1] & addb[1]) | (adda[1] & carry[0]) | (addb[1] & carry[0]) | ((adda[0] & addb[0]) | (adda[0] & carry[0]) | (addb[0] & carry[0])) & (sum_result[0] == sum_result[1]);

  // Stage 3
  assign sum_result[2] = sum_result[1] + {carry[1], adda[3:2], addb[3:2]};
  assign carry[2] = (adda[3] & addb[3]) | (adda[3] & carry[1]) | (addb[3] & carry[1]) | ((adda[2] & addb[2]) | (adda[2] & carry[1]) | (addb[2] & carry[1])) & (sum_result[1] == sum_result[2]);

  // Stage 4
  assign result = {carry[3], sum_result[2]};

  // Enable signal pipeline stages
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      en_pipeline[0] <= 0;
      en_pipeline[1] <= 0;
      en_pipeline[2] <= 0;
      en_pipeline[3] <= 0;
    end
    else begin
      en_pipeline[0] <= i_en;
      en_pipeline[1] <= en_pipeline[0];
      en_pipeline[2] <= en_pipeline[1];
      en_pipeline[3] <= en_pipeline[2];
    end
  end

  // Output enable signal synchronization
  reg o_en_sync;
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
      o_en_sync <= 0;
    else
      o_en_sync <= en_pipeline[3];
  end

  assign o_en = o_en_sync;

endmodule