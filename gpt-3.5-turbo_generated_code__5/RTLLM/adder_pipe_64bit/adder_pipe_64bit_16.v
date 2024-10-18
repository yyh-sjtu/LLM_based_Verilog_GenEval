module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum1, sum2, sum3, sum4, sum5, sum6;
reg [65:0] carry;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)
        carry <= 66'b0;
    else begin
        if (i_en) begin
            sum1 <= adda + addb;
            sum2 <= sum1 + carry[1:0];
            sum3 <= sum2 + carry[3:2];
            sum4 <= sum3 + carry[5:4];
            sum5 <= sum4 + carry[7:6];
            sum6 <= sum5 + carry[9:8];
            carry <= {sum1[63], sum1[63]} + {sum2[63], sum2[63]} + {sum3[63], sum3[63]} 
                     + {sum4[63], sum4[63]} + {sum5[63], sum5[63]} + {sum6[63], sum6[63]};
        end
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)
        result <= 65'b0;
    else begin
        if (i_en)
            result <= {sum6, carry[65:1]};
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)
        o_en <= 1'b0;
    else begin
        if (i_en)
            o_en <= 1'b1;
        else
            o_en <= 1'b0;
    end
end

endmodule

