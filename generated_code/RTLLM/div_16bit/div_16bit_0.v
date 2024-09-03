module div_16bit (
  input [15:0] A,
  input [7:0] B,
  output reg [15:0] result,
  output reg [15:0] odd
);

  reg [15:0] a_reg;
  reg [7:0] b_reg;
  reg [15:0] remainder;

  always @(*) begin
    a_reg = A;
    b_reg = B;
  end

  always @(*) begin
    remainder = a_reg;
    result = 16'b0;
    odd = 16'b0;
    
    for (int i = 15; i >= 8; i = i - 1) begin
      if (remainder[i] == 1'b1) begin
        if (remainder[i-8:0] >= b_reg) begin
          result[i-8] = 1;
          remainder[i-8:0] = remainder[i-8:0] - b_reg;
        end
      end
    end
    
    odd = remainder;
  end
endmodule
