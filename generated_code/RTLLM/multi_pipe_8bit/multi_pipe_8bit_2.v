
module multi_pipe_8bit (
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

reg [15:0] mul_out_reg;
reg [7:0] mul_a_reg, mul_b_reg;
reg [15:0] temp [7:0];
reg [15:0] sum [7:0];

always @(posedge clk) begin
    // Input control
    if (rst_n == 0) begin
        mul_en_out <= 0;
    end else begin
        mul_en_out <= mul_en_in;
    end

    if (mul_en_out) begin
        // Input registers
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;

        // Partial Product Generation
        for (int i = 0; i < 8; i = i + 1) begin
            temp[i] <= mul_en_out ? mul_a_reg & (1 << i) : 0;
        end

        // Partial Sum Calculation
        for (int i = 0; i < 8; i = i + 1) begin
            sum[i] <= (i == 0) ? temp[0] : sum[i-1] + temp[i];
        end
        
        // Final Product Calculation
        mul_out_reg <= sum[7];
    end
end

always @(*) begin
    // Output assignment
    if (mul_en_out) begin
        mul_out =  mul_out_reg;
    end else begin
        mul_out = 16'd0;
    end
end

endmodule