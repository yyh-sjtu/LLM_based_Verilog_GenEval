module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [7:0] a_reg, b_reg;
reg [15:0] dividend;
reg [3:0] count;
reg [15:0] tmp_result;

always @* begin
    a_reg = A;
    b_reg = B;
    dividend = A;
    count = 0;
    result = 0;
    odd = 0;
    
    tmp_result = 0;
    while(count < 16) begin
        if(dividend[15] == 1) begin
            tmp_result = tmp_result << 1;
            tmp_result[0] = 1;
            dividend = dividend - b_reg;
        end
        else begin
            tmp_result = tmp_result << 1;
        end
        count = count + 1;
        dividend = dividend << 1;
    end
    
    result = tmp_result;
    odd = dividend;
    
end

endmodule
