module div_16bit(
    input [15:0] A,
    input [7:0] B,
    output [15:0] result,
    output [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;
reg [15:0] result_reg;
reg [15:0] odd_reg;

always @(*) begin
    a_reg = A;
    b_reg = B;
end

always @(*) begin
    reg [3:0] i;
    reg [15:0] temp_a;
    reg [15:0] temp_result;
    reg [15:0] temp_odd;
    
    temp_a = a_reg;
    temp_result = 0;
    temp_odd = 0;
    
    for(i=0; i<16; i=i+1) begin
        temp_a = temp_a << 1;
        temp_odd = temp_odd << 1;
        
        if(temp_a[15] == 1) begin
            temp_odd[0] = 1;
            if(temp_a >= b_reg) begin
                temp_result[15-i] = 1;
                temp_a = temp_a - b_reg;
            end
        end
    end
    
    result_reg = temp_result;
    odd_reg = temp_odd;
end

assign result = result_reg;
assign odd = odd_reg;

endmodule

