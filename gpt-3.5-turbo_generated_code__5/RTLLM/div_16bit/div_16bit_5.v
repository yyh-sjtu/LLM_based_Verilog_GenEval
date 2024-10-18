module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;

always @(*)
begin
    a_reg = A;
    b_reg = B;
end

always @(*)
begin
    reg [7:0] remainder;
    reg [15:0] quotient;
    reg [15:0] temp;
    
    remainder = 0;
    quotient = 0;
    temp = 0;
    
    for (int i = 15; i >= 0; i=i-1)
    begin
        remainder = remainder << 1;
        temp = {remainder, a_reg[i]};
        
        if (temp >= b_reg) 
        begin
            remainder = temp - b_reg;
            quotient[i] = 1;
        end 
        else 
        begin
            remainder = temp;
            quotient[i] = 0;
        end
    end

    result = quotient;
    odd = remainder;
end

endmodule

