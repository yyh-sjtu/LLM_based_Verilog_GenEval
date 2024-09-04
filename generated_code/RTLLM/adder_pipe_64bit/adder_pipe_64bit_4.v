
module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum1, sum2, sum3, sum4; // Pipeline stages for sum calculation
reg carry1, carry2, carry3; // Pipeline stages for carry calculation

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 0;
        carry1 <= 0;
        sum2 <= 0;
        carry2 <= 0;
        sum3 <= 0;
        carry3 <= 0;
        result <= 0;
        o_en <= 0;
    end else begin
        if (i_en) begin
            // Stage 1
            {sum1, carry1} <= adda + addb;
            
            // Stage 2
            {sum2, carry2} <= sum1 + carry1;

            // Stage 3
            {sum3, carry3} <= sum2 + carry2;

            // Stage 4
            result <= {sum3, carry3};
            o_en <= 1;
        end else begin
            result <= 0;
            o_en <= 0;
        end
    end
end

endmodule