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
    reg [15:0] remainder;
    reg [15:0] quotient;
    reg [15:0] higher_bits;
    reg [3:0] shift_count;

    remainder = a_reg;
    shift_count = 0;
    quotient = 0;

    while (shift_count < 8) begin
        higher_bits = {remainder[15:8], 8'b0};

        if (higher_bits >= b_reg) begin
            quotient = quotient << 1 | 1;
            remainder = remainder << 1 - b_reg;
        else begin
            quotient = quotient << 1;
            remainder = remainder << 1;
        end
        shift_count = shift_count + 1;
    end

    result = quotient;
    odd = remainder;
end

endmodule

