
module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;
reg [15:0] remainder;

always @* begin
    a_reg = A;
    b_reg = B;
end

always @* begin
    result = 16'b0;
    remainder = a_reg;

    for (int i = 15; i >= 8; i = i - 1) begin
        if (remainder[i] == 1'b1) begin
            remainder = remainder << (i - 8);
            if (remainder >= b_reg) begin
                result[i-8] = 1'b1;
                remainder = remainder - b_reg;
            end
        end
    end

    odd = remainder;
end

endmodule