
module div_16bit (
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
        reg [15:0] quotient_tmp;
        reg [15:0] remainder_tmp;
        reg [15:0] a_tmp;
        reg [15:0] odd_tmp;
        
        a_tmp = a_reg;
        odd_tmp = 16'b0;
        quotient_tmp = 16'b0;
        remainder_tmp = 16'b0;
        
        for (int i = 15; i >= 0; i = i-1) begin
            odd_tmp = odd_tmp << 1;
            odd_tmp[0] = a_tmp[15];
            if (a_tmp >= b_reg) begin
                quotient_tmp[i] = 1;
                remainder_tmp = a_tmp - b_reg;
            end
            else begin
                quotient_tmp[i] = 0;
                remainder_tmp = a_tmp;
            end
            a_tmp = remainder_tmp;
        end

        result = quotient_tmp;
        odd = odd_tmp;
    end

endmodule