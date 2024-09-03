
module adder_pipe_64bit(
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum1, sum2, sum3, sum4;
reg c1, c2, c3;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 64'b0;
        sum2 <= 64'b0;
        sum3 <= 64'b0;
        sum4 <= 64'b0;
        c1 <= 1'b0;
        c2 <= 1'b0;
        c3 <= 1'b0;
        result <= 65'b0;
        o_en <= 1'b0;
    end
    else begin
        if (i_en) begin
            sum1 <= adda + addb;
            c1 <= sum1[63];
            sum2 <= sum1 + {1'b0, c1};
            c2 <= sum2[64];
            sum3 <= sum2 + {1'b0, c2};
            c3 <= sum3[65];
            sum4 <= sum3 + {1'b0, c3};
            result <= {c3, sum4};
            o_en <= 1'b1;
        end
    end
end

endmodule