module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;
reg [3:0] shift_cnt;
reg [15:0] quotient_temp;
reg [15:0] rem_temp;
reg [15:0] temp;

always @* begin
    a_reg = A;
    b_reg = B;
end

always @* begin
    temp = a_reg;
    shift_cnt = 0;
    
    for (shift_cnt = 0; shift_cnt < 16; shift_cnt = shift_cnt + 1) begin
        if (temp[15] == 1'b1) begin
            temp = temp - (b_reg << (15 - shift_cnt));
            quotient_temp[shift_cnt] = 1;
        end
        else quotient_temp[shift_cnt] = 0;
    end
    
    result = quotient_temp;
    odd = temp;
end

endmodule

