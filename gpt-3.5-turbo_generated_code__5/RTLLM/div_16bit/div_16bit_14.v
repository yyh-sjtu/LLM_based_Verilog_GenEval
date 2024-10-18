
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
        reg [7:0] rem;
        reg [7:0] temp_b;
        reg [3:0] shift_count;

        result = 0;
        rem = a_reg[15:8];
        temp_b = b_reg;

        for (shift_count = 0; shift_count < 8; shift_count = shift_count + 1) begin
            if (rem >= temp_b) begin
                result[15 - shift_count] = 1;
                rem = rem - temp_b;
            end else begin
                result[15 - shift_count] = 0;
            end
            temp_b = temp_b >> 1;
            if(shift_count < 7)
                rem = {rem[6:0], a_reg[7 - shift_count]};
        end

        odd = rem;
    end

endmodule