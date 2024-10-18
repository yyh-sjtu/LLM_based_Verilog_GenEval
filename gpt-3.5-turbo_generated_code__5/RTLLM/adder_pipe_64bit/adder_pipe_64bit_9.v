
module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum1, sum2, sum3, sum4;
reg [64:0] carry;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 0;
        sum2 <= 0;
        sum3 <= 0;
        sum4 <= 0;
        carry <= 0;
        o_en <= 0;
    end else begin
        if (i_en) begin
            sum1 <= adda[0] + addb[0] + carry[0];
            sum2 <= adda[1] + addb[1] + carry[1];
            sum3 <= adda[2] + addb[2] + carry[2];
            sum4 <= adda[3] + addb[3] + carry[3];
            carry <= (sum1[64] | sum2[64] | sum3[64] | sum4[64]);
        end
        o_en <= i_en;
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        result <= 0;
    end else begin
        if (i_en) begin
            result <= {sum4, sum3, sum2, sum1, carry[63:1]};
        end
    end
end

endmodule