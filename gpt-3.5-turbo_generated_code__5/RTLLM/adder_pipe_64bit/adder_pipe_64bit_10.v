
module adder_pipe_64bit(
  input clk, rst_n, i_en,
  input [63:0] adda, addb,
  output [64:0] result,
  output o_en
);

  reg [63:0] sum_p0, sum_p1, sum_p2, sum_p3, sum_p4, sum_p5;
  reg carry_p0, carry_p1, carry_p2, carry_p3, carry_p4, carry_p5;

  reg o_en_p0, o_en_p1, o_en_p2, o_en_p3;
  
  // Pipeline stage 0
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sum_p0 <= 'b0;
      carry_p0 <= 1'b0;
      o_en_p0 <= 1'b0;
    end else if (i_en) begin
      sum_p0 <= adda + addb;
      carry_p0 <= sum_p0[63];
      o_en_p0 <= 1'b1;
    end
  end
  
  // Pipeline stage 1
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sum_p1 <= 'b0;
      carry_p1 <= 1'b0;
      o_en_p1 <= 1'b0;
    end else begin
      sum_p1 <= sum_p0;
      carry_p1 <= carry_p0;
      o_en_p1 <= o_en_p0;
    end
  end
  
  // Pipeline stage 2
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sum_p2 <= 'b0;
      carry_p2 <= 1'b0;
      o_en_p2 <= 1'b0;
    end else begin
      sum_p2 <= sum_p1;
      carry_p2 <= carry_p1;
      o_en_p2 <= o_en_p1;
    end
  end
  
  // Pipeline stage 3
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sum_p3 <= 'b0;
      carry_p3 <= 1'b0;
      o_en_p3 <= 1'b0;
    end else begin
      sum_p3 <= sum_p2;
      carry_p3 <= carry_p2;
      o_en_p3 <= o_en_p2;
    end
  end

  // Combinational logic for final output
  always @* begin
    result[63:0] = sum_p3;
    result[64] = carry_p3;
    o_en = o_en_p3;
  end
  
endmodule