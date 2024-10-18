
module div_16bit (
  input [15:0] A,
  input [7:0] B,
  output reg [15:0] result,
  output reg [15:0] odd
);

  reg [15:0] a_reg;
  reg [7:0] b_reg;

  always @* begin
    a_reg = A;
    b_reg = B;
  end

  always @* begin
    reg [15:0] dividend_bit;
    reg [15:0] quotient_bit;
    reg [15:0] dividend_remainder;
    reg [15:0] dividend_high;
    reg [7:0] divisor_shift;
  
    dividend_high = {a_reg[15:8], 8'b0};
    dividend_remainder = a_reg;
    result = 16'b0;
    
    for (dividend_bit = 15; dividend_bit >= 0; dividend_bit = dividend_bit - 1) begin
      if (dividend_remainder >= b_reg) begin
        quotient_bit = 1;
        dividend_remainder = dividend_remainder - b_reg;
      end else begin
        quotient_bit = 0;
      end
      result[dividend_bit] = quotient_bit;
      divisor_shift = {b_reg, 1'b0};
      b_reg = divisor_shift;
    end
  
    odd = {dividend_remainder, dividend_high[7]};
  end

endmodule