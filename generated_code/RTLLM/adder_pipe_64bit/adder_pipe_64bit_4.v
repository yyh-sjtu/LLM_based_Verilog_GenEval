
module adder_pipe_64bit (
    input wire clk,
    input wire rst_n,
    input wire i_en,
    input wire [63:0] adda,
    input wire [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum1, sum2, sum3, sum4, sum5;
reg [4:0] carry1, carry2, carry3, carry4;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 64'h0;
        sum2 <= 64'h0;
        sum3 <= 64'h0;
        sum4 <= 64'h0;
        sum5 <= 64'h0;
        carry1 <= 5'h0;
        carry2 <= 5'h0;
        carry3 <= 5'h0;
        carry4 <= 5'h0;
        result <= 65'h0;
        o_en <= 1'b0;
    end else begin
        if (i_en) begin
            sum1 <= adda + addb;
            carry1 <= sum1[64];
            sum2 <= sum1[63:0] + {1'b0, carry1};
            carry2 <= sum2[64];
            sum3 <= sum2[63:0] + {1'b0, carry2};
            carry3 <= sum3[64];
            sum4 <= sum3[63:0] + {1'b0, carry3};
            carry4 <= sum4[64];
            sum5 <= sum4[63:0] + {1'b0, carry4};
            result <= {sum5, carry4};
            o_en <= 1'b1;
        end else begin
            o_en <= 1'b0;
        end
    end
end

endmodule