module
module full_adder_16bit (
    input [15:0] A, 
    input [15:0] B, 
    input cin,
    output [15:0] sum,
    output cout
);

    reg [15:0] sum_reg;
    reg cout_reg;
    
    always @* begin
        sum_reg = A + B + cin;
        cout_reg = (A[15] & B[15]) | (A[15] & cin) | (B[15] & cin);
    end 
    
    assign sum = sum_reg;
    assign cout = cout_reg;
    
endmodule

module with taps at bit positions 5 and 3
module lfsr( 
    input clk,
    input reset,
    output reg [4:0] q
); 
    reg [4:0] r_reg;
    wire [4:0] r_next;
    wire feedback_value;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_reg <= 5'b1;
        end else begin
            r_reg <= r_next;
        end
    end
    
    assign r_next[4] = r_reg[3] ^ r_reg[4];
    assign r_next[3:0] = r_reg[4:1];
    
    assign feedback_value = r_reg[3] ^ r_reg[4];
    assign q = r_reg;
endmodule

