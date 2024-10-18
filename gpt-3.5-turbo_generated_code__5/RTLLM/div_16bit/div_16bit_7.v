
module div_16bit(
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
    );

    reg [15:0] a_reg;
    reg [7:0] b_reg;
    reg [15:0] quotient_reg;
    reg [15:0] remainder_reg;

    always @* begin
        a_reg = A;
        b_reg = B;
    end

    always @* begin
        quotient_reg = 0;
        remainder_reg = a_reg;

        for (i = 15; i >= 8; i = i - 1) begin
            if (remainder_reg[i] == 1'b1) begin
                quotient_reg[i-8] = 1;
                remainder_reg = remainder_reg - (b_reg << (i - 8));
            end
        end

        result = quotient_reg;
        odd = remainder_reg;
    end

endmodule