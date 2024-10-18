module adder_pipe_64bit (
    input clk,        // Clock input
    input rst_n,      // Active low reset signal
    input i_en,       // Enable signal for addition operation
    input [63:0] adda,    // 64-bit input operand A
    input [63:0] addb,    // 64-bit input operand B
    output [64:0] result,  // 65-bit output representing the sum of adda and addb
    output reg o_en       // Output enable signal
);

reg [63:0] sum_stage_0;
reg [63:0] sum_stage_1;
reg [63:0] sum_stage_2;
reg [63:0] sum_stage_3;
reg [63:0] sum_stage_4;
reg [63:0] sum_stage_5;
reg [63:0] sum_stage_6;
reg [63:0] sum_stage_7;
reg [64:0] sum_result;

reg [63:0] carry_stage_0;
reg [63:0] carry_stage_1;
reg [63:0] carry_stage_2;
reg [63:0] carry_stage_3;
reg [63:0] carry_stage_4;
reg [63:0] carry_stage_5;
reg [63:0] carry_stage_6;
reg [63:0] carry_stage_7;
reg [64:0] carry_out;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum_stage_0 <= 64'b0;
        sum_stage_1 <= 64'b0;
        sum_stage_2 <= 64'b0;
        sum_stage_3 <= 64'b0;
        sum_stage_4 <= 64'b0;
        sum_stage_5 <= 64'b0;
        sum_stage_6 <= 64'b0;
        sum_stage_7 <= 64'b0;
        sum_result <= 65'b0;
        
        carry_stage_0 <= 64'b0;
        carry_stage_1 <= 64'b0;
        carry_stage_2 <= 64'b0;
        carry_stage_3 <= 64'b0;
        carry_stage_4 <= 64'b0;
        carry_stage_5 <= 64'b0;
        carry_stage_6 <= 64'b0;
        carry_stage_7 <= 64'b0;
        carry_out <= 65'b0;
        
        o_en <= 1'b0;
    end
    else if (i_en) begin
        sum_stage_0 <= adda[0] + addb[0];
        carry_stage_0 <= adda[0] & addb[0];
        
        sum_stage_1 <= adda[1] + addb[1] + carry_stage_0;
        carry_stage_1 <= (adda[1] & addb[1]) | (adda[1] & carry_stage_0) | (addb[1] & carry_stage_0);
        
        sum_stage_2 <= adda[2] + addb[2] + carry_stage_1;
        carry_stage_2 <= (adda[2] & addb[2]) | (adda[2] & carry_stage_1) | (addb[2] & carry_stage_1);
        
        sum_stage_3 <= adda[3] + addb[3] + carry_stage_2;
        carry_stage_3 <= (adda[3] & addb[3]) | (adda[3] & carry_stage_2) | (addb[3] & carry_stage_2);
        
        sum_stage_4 <= adda[4] + addb[4] + carry_stage_3;
        carry_stage_4 <= (adda[4] & addb[4]) | (adda[4] & carry_stage_3) | (addb[4] & carry_stage_3);
        
        sum_stage_5 <= adda[5] + addb[5] + carry_stage_4;
        carry_stage_5 <= (adda[5] & addb[5]) | (adda[5] & carry_stage_4) | (addb[5] & carry_stage_4);
        
        sum_stage_6 <= adda[6] + addb[6] + carry_stage_5;
        carry_stage_6 <= (adda[6] & addb[6]) | (adda[6] & carry_stage_5) | (addb[6] & carry_stage_5);
        
        sum_stage_7 <= adda[7] + addb[7] + carry_stage_6;
        carry_stage_7 <= (adda[7] & addb[7]) | (adda[7] & carry_stage_6) | (addb[7] & carry_stage_6);
        
        sum_result <= {carry_stage_7, sum_stage_7, sum_stage_6, sum_stage_5, sum_stage_4, sum_stage_3, sum_stage_2, sum_stage_1, sum_stage_0};
        carry_out <= {carry_stage_7, carry_stage_6, carry_stage_5, carry_stage_4, carry_stage_3, carry_stage_2, carry_stage_1, carry_stage_0};
        
        o_en <= 1'b1;
    end
    else begin
        o_en <= 1'b0;
    end
end

assign result = sum_result;

endmodule

