
module div_16bit(
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
    reg [15:0] dividend_bits;
    reg [3:0] dividend_index;
    reg [15:0] quotient;
    reg [15:0] remainder;
    reg [3:0] highest_bit_index;

    dividend_bits = a_reg[dividend_index+:8];
    quotient = quotient << 1;
    remainder = {remainder, a_reg[dividend_index]};
    highest_bit_index = $countones(dividend_bits);

    if (dividend_bits >= b_reg)
        quotient[0] = 1;
    else
        quotient[0] = 0;

    if (highest_bit_index > 0)
        dividend_index = dividend_index + highest_bit_index - 1;
    else
        dividend_index = 0;

    if (dividend_index == 12)
        dividend_index = 11;

    if (dividend_index == 10)
        dividend_index = 9;

    if (dividend_index == 8)
        dividend_index = 7;

    if (dividend_index == 6)
        dividend_index = 5;

    if (dividend_index == 4)
        dividend_index = 3;

    if (dividend_index == 2)
        dividend_index = 1;

    if (dividend_index == 0)
        dividend_index = 15;

    if (dividend_index >= 8)
        dividend_index = 7;
    else
        dividend_index = dividend_index - 1;

    if (dividend_index == 12)
        dividend_index = 11;

    if (dividend_index == 10)
        dividend_index = 9;

    if (dividend_index == 8)
        dividend_index = 7;

    if (dividend_index == 6)
        dividend_index = 5;

    if (dividend_index == 4)
        dividend_index = 3;

    if (dividend_index == 2)
        dividend_index = 1;

    if (dividend_index == 0)
        dividend_index = 15;

    remainder = remainder - (b_reg << highest_bit_index);

    if (remainder < 0)
        remainder = remainder + (b_reg << highest_bit_index);

    result = quotient;
    odd = remainder;
end

endmodule