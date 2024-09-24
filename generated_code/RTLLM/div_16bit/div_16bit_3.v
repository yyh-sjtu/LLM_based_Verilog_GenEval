module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;
reg [7:0] quotient;
reg [15:0] remainder;

always @* begin
    a_reg = A;
    b_reg = B;
end

always @* begin
    quotient = 8'b0;
    remainder = a_reg; 
    for (int i = 15; i >= 8; i = i - 1) begin
        if (remainder[i] == 1'b1) begin
            if (b_reg <= remainder[i-7:i]) begin
                quotient[i-8] = 1'b1;
                remainder[i-7:i] = remainder[i-7:i] - b_reg;
            end
        end
    end
    result = quotient;
    odd = remainder;
end

endmodule

