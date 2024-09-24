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
    reg [15:0] temp_remainder;
    reg [7:0] temp_quotient;
    
    temp_remainder = a_reg;
    temp_quotient = 16'b0;
    
    for (int i = 0; i < 8; i = i + 1) begin
        if(temp_remainder[15] == 1'b1) begin
            temp_remainder = temp_remainder - b_reg;
            temp_quotient[7-i] = 1'b1;
        end
        
        temp_remainder = temp_remainder << 1;
    end
    
    result = temp_quotient;
    odd = temp_remainder;
end

endmodule

