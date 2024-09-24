module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;

always @(*) begin
    a_reg = A;
    b_reg = B;
end

always @(*) begin
    reg [15:0] dividend;
    reg [7:0] divisor;
    reg [15:0] quotient;
    reg [15:0] remainder;

    dividend = a_reg;
    divisor = b_reg;
    quotient = 0;
    remainder = 0;
    
    for (int i = 15; i >= 0; i = i - 1) begin
        remainder = remainder << 1;
        remainder[0] = dividend[i];

        if (remainder >= divisor) begin
            remainder = remainder - divisor;
            quotient[i] = 1;
        end
    end

    result = quotient;
    odd = remainder;
end

endmodule

