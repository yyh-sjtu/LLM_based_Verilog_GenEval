
module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] add_results [4:0]; // Pipeline stage registers

reg [64:0] sum [4:0]; // Sum of adda, addb, and carry
reg [4:0] carry; // Carry signals for each stage

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i = 0; i < 5; i = i + 1) begin
            add_results[i] <= 0;
            sum[i] <= 0;
            o_en <= 0;
        end
        carry <= 0;
    end else begin
        // Pipeline stages
        for (int i = 4; i >= 0; i = i - 1) begin
            if (i == 4) begin
                add_results[i] <= i_en ? adda + addb : 0;
            end else begin
                sum[i+1] <= add_results[i+1] + carry[i+1];
                add_results[i] <= sum[i+1][63:0];
                carry[i] <= sum[i+1][64];
            end
        end
        
        // Output result
        result <= sum[0];
        o_en <= i_en;
    end
end

endmodule