module div_16bit(
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
    reg [7:0] remainder = 0;
    reg [15:0] temp_result = 0;
    
    for (int i = 15; i >= 0; i = i - 1) begin
        remainder = (remainder << 1) | a_reg[i];
        
        if (remainder >= b_reg) begin
            remainder = remainder - b_reg;
            temp_result[i] = 1;
        end
    end
    
    result = temp_result;
    odd = remainder;
end

endmodule

