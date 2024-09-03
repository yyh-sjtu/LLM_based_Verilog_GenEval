
module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum_0, sum_1, sum_2, sum_3, sum_4;
reg carry_0 = 1'b0, carry_1 = 1'b0, carry_2 = 1'b0, carry_3 = 1'b0;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum_0 <= 64'b0;
        sum_1 <= 64'b0;
        sum_2 <= 64'b0;
        sum_3 <= 64'b0;
        sum_4 <= 64'b0;
        carry_0 <= 1'b0;
        carry_1 <= 1'b0;
        carry_2 <= 1'b0;
        carry_3 <= 1'b0;
        o_en <= 1'b0;
    end else begin
        if (i_en) begin
            sum_0 <= adda + addb + carry_0;
            sum_1 <= sum_0;
            sum_2 <= sum_1;
            sum_3 <= sum_2;
            sum_4 <= sum_3;
            carry_0 <= sum_0[64];
            carry_1 <= sum_1[64];
            carry_2 <= sum_2[64];
            carry_3 <= sum_3[64];
            o_en <= 1'b1;
        end
    end
end

assign result = {carry_3, sum_4};

endmodule