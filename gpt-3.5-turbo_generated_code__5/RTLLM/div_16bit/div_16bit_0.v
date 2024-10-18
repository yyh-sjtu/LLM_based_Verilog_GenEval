
module div_16bit (
  input [15:0] A,
  input [7:0] B,
  output [15:0] result,
  output [15:0] odd
);

  reg [15:0] a_reg;
  reg [7:0] b_reg;
  reg [15:0] quotient;

  always @* begin
    a_reg = A;
    b_reg = B;
  end

  always @* begin
    reg [15:0] dividend;
    reg [3:0] shift_amount;
    reg [15:0] remaining_bits;
    reg [15:0] new_dividend;
    reg [7:0] divisor;

    dividend = a_reg;
    divisor = b_reg;
    shift_amount = 0;
    quotient = 0;

    for (shift_amount = 15; shift_amount >= 0; shift_amount = shift_amount - 1) begin
      if (dividend[shift_amount + 7:shift_amount] >= divisor) begin
        quotient[shift_amount] = 1;
        remaining_bits = dividend[shift_amount + 7:shift_amount] - divisor;
        new_dividend = {remaining_bits, dividend[shift_amount + 6:0]};
      end
      else begin
        quotient[shift_amount] = 0;
        new_dividend = {dividend[shift_amount + 7:shift_amount], dividend[shift_amount + 6:0]};
      end

      dividend = new_dividend;
    end

    result = quotient;
    odd = dividend;
  end

endmodule