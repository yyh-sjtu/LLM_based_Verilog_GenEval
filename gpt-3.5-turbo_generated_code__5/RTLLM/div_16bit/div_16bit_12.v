
module div_16bit (
  input [15:0] A,
  input [7:0] B,
  output reg [15:0] result,
  output reg [15:0] odd
);

  reg [15:0] a_reg;
  reg [7:0] b_reg;
  reg [8:0] remainder_reg;
  reg [3:0] quotient_reg;
  
  always @* begin
    a_reg = A;
    b_reg = B;
  end
  
  always @* begin
    remainder_reg = 16'd0;
    quotient_reg = 4'd0;
    
    for (int i = 15; i >= 0; i = i-1) begin
      remainder_reg = {remainder_reg[7:0], A[i]};
      if (remainder_reg >= b_reg) begin
        remainder_reg = remainder_reg - b_reg;
        quotient_reg[i/4] = quotient_reg[i/4] | (1 << (i%4));
      end
    end
    
    result = quotient_reg;
    odd = remainder_reg;
  end
  
endmodule