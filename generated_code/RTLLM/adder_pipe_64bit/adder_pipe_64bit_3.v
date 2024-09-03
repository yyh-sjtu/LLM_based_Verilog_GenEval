
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
reg [64:0] carry1, carry2, carry3, carry4, carry5;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 64'h0;
        sum2 <= 64'h0;
        sum3 <= 64'h0;
        sum4 <= 64'h0;
        sum5 <= 64'h0;
        sum6 <= 64'h0;
        
        carry1 <= 1'b0;
        carry2 <= 1'b0;
        carry3 <= 1'b0;
        carry4 <= 1'b0;
        carry5 <= 1'b0;
        
        result <= 65'h0;
        o_en <= 1'b0;
    end else begin
        if (i_en) begin
            sum1 <= adda + addb;
            carry1 <= sum1[63] | (sum1[63] & (adda[62:0] | addb[62:0]));
            
            sum2 <= sum1 + {1'b0, carry1};
            carry2 <= sum2[63] | (sum2[63] & (sum1[62:0] | 1'b0));
            
            sum3 <= sum2 + {1'b0, carry2};
            carry3 <= sum3[63] | (sum3[63] & (sum2[62:0] | 1'b0));
            
            sum4 <= sum3 + {1'b0, carry3};
            carry4 <= sum4[63] | (sum4[63] & (sum3[62:0] | 1'b0));
            
            sum5 <= sum4 + {1'b0, carry4};
            carry5 <= sum5[63] | (sum5[63] & (sum4[62:0] | 1'b0));
            
            sum6 <= sum5 + {1'b0, carry5};
            
            result <= {1'b0, sum6};
            o_en <= 1'b1;
        end else begin
            result <= 65'h0;
            o_en <= 1'b0;
        end
    end
end

endmodule