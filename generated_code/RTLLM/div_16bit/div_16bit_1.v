module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;
reg [15:0] temp_remainder;

always @* begin
    a_reg = A;
    b_reg = B;
end

always @* begin
    result = 16'b0;
    temp_remainder = a_reg;

    for (int i = 15; i >= 8; i = i-1) begin
        if(temp_remainder[i] >= b_reg) begin
            result[i-8] = 1;
            temp_remainder[i] = temp_remainder[i] - b_reg;
        end
        else begin
            result[i-8] = 0;
        end
    end

    odd = temp_remainder;
end

endmodule

