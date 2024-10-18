module div_16bit(
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] remainder
);

reg [15:0] a_reg;
reg [7:0] b_reg;
reg [3:0] shift_count;
reg [15:0] temp_remainder;

always @* begin
    a_reg = A;
    b_reg = B;
end

always @* begin
    result = 16'd0;
    remainder = 16'd0;
    shift_count = 4'd0;
    temp_remainder = a_reg;

    while(shift_count < 12) begin
        if(temp_remainder[15] == 1'b1) begin
            temp_remainder = temp_remainder - (b_reg << (shift_count-8));
            remainder[shift_count-1:0] = temp_remainder[15:shift_count];
            result[15-shift_count] = 1;
        end
        shift_count = shift_count + 1;
    end
end

endmodule

