module div_16bit(
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

always @(*)
begin
    reg [15:0] a_reg;
    reg [7:0] b_reg;
    
    a_reg = A;
    b_reg = B;
    
    for (int i = 0; i < 8; i = i + 1)
    begin
        if (a_reg[15] == 1'b1)
        begin
            a_reg = a_reg - b_reg;
            result[i] = 1'b1;
        end
        else
        begin
            result[i] = 1'b0;
        end
        a_reg = a_reg << 1;
    end
    
    odd = a_reg;
end

endmodule

