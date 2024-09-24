
module adder_pipe_64bit(
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum_0, sum_1, sum_2, sum_3, sum_4;
reg [4:0] carry;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum_0 <= 0;
        sum_1 <= 0;
        sum_2 <= 0;
        sum_3 <= 0;
        sum_4 <= 0;
        carry <= 0;
        result <= 0;
        o_en <= 0;
    end
    else if (i_en) begin
        sum_0 <= adda + addb;
        sum_1 <= sum_0 + carry[0];
        sum_2 <= sum_1 + carry[1];
        sum_3 <= sum_2 + carry[2];
        sum_4 <= sum_3 + carry[3];
        
        carry <= {sum_0[64], sum_1[64], sum_2[64], sum_3[64], sum_4[64]};
        
        result <= sum_4;
        o_en <= 1;
    end
    else begin
        result <= 0;
        o_en <= 0;
    end
end

endmodule