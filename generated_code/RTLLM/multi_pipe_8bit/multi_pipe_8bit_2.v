
module multi_pipe_8bit (
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

reg [7:0] mul_a_reg;
reg [7:0] mul_b_reg;
reg [15:0] mul_out_reg;
reg [7:0] temp [7:0];
reg [15:0] sum [7:0];
reg [7:0] mul_en_out_reg;

always @(posedge clk) begin
    // Input Control
    mul_en_out_reg <= {mul_en_out_reg[6:0], mul_en_in};

    // Input Registers
    if (mul_en_in) begin
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;
    end

    // Partial Product Generation
    for (int i = 0; i < 8; i = i + 1) begin
        for (int j = 0; j < 8; j = j + 1) begin
            temp[i][j] = (mul_b_reg[j] && (i == j)) ? mul_a_reg : 8'b0;
        end
    end

    // Partial Sum Calculation
    for (int i = 0; i < 8; i = i + 1) begin
        sum[i] <= sum[i] + temp[i];
    end

    // Final Product Calculation
    mul_out_reg <= sum[0];
    for (int i = 1; i < 8; i = i + 1) begin
        mul_out_reg <= mul_out_reg + (sum[i] << i);
    end

    // Output Assignment
    mul_out <= (mul_en_out_reg[7]) ? mul_out_reg : 16'b0;
    mul_en_out <= mul_en_out_reg[7];
end

// Reset logic
always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_en_out <= 0;
        mul_out <= 0;
        mul_a_reg <= 8'b0;
        mul_b_reg <= 8'b0;
        mul_out_reg <= 16'b0;
        mul_en_out_reg <= 8'b0;
        for (int i = 0; i < 8; i = i + 1) begin
            sum[i] <= 16'b0;
            for (int j = 0; j < 8; j = j + 1) begin
                temp[i][j] <= 8'b0;
            end
        end
    end
end

endmodule