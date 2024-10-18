module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output [15:0] result,
    output [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;

always @* begin
    a_reg = A;
    b_reg = B;
end

always @* begin
    reg [15:0] quotient;
    reg [15:0] remainder;
    reg [15:0] temp;
    
    quotient = 0;
    remainder = 0;
    temp = 0;
    
    for (int i=15; i>=0; i=i-1) begin
        temp = {remainder, a_reg[15]};
        remainder = temp;
        if (temp >= b_reg) begin
            remainder = temp - b_reg;
            quotient = {quotient[14:0], 1};
        end else begin
            quotient = {quotient[14:0], 0};
        end
        a_reg = a_reg << 1;
    end
    
    result = quotient;
    odd = remainder;
end

endmodule

