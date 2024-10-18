module adder_pipe_64bit (
    input wire clk,
    input wire rst_n,
    input wire i_en,
    input wire [63:0] adda,
    input wire [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum1, sum2, sum3, sum4;
reg [64:0] carry1, carry2, carry3;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 64'b0;
        carry1 <= 65'b0;
        sum2 <= 64'b0;
        carry2 <= 65'b0;
        sum3 <= 64'b0;
        carry3 <= 65'b0;
        result <= 65'b0;
        o_en <= 1'b0;
    end else begin
        if (i_en) begin
            sum1 <= adda + addb;
            carry1 <= {1'b0, adda} + {1'b0, addb};

            sum2 <= sum1 + carry1[63:0];
            carry2 <= {1'b0, sum1} + {1'b0, carry1[63:0]};

            sum3 <= sum2 + carry2[63:0];
            carry3 <= {1'b0, sum2} + {1'b0, carry2[63:0]};

            result <= sum3 + carry3[63:0];
            o_en <= 1'b1;
        end else begin
            result <= 65'b0;
            o_en <= 1'b0;
        end
    end
end

endmodule

