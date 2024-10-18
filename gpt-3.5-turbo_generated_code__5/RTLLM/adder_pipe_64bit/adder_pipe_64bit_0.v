
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
reg [64:0] carry1, carry2, carry3;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 64'b0;
        sum2 <= 64'b0;
        sum3 <= 64'b0;
        sum4 <= 64'b0;
        carry1 <= 65'b0;
        carry2 <= 65'b0;
        carry3 <= 65'b0;
        result <= 65'b0;
        o_en <= 1'b0;
    end
    else if (i_en) begin
        // Pipeline stage 1
        {carry1[0], sum1} <= adda + addb;
        
        // Pipeline stage 2
        {carry2[0], sum2} <= sum1 + carry1;
        
        // Pipeline stage 3
        {carry3[0], sum3} <= sum2 + carry2;
        
        // Final stage
        result <= {carry3[1], sum3};
        o_en <= 1'b1;
    end
end

endmodule