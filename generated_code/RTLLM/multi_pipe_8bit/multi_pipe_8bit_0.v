
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

reg [7:0] temp [7:0];
reg [15:0] sum [7:0];
reg [15:0] mul_out_reg;

reg mul_en_out_reg;

// Input Control
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_en_out_reg <= 0;
    end else begin
        mul_en_out_reg <= mul_en_in;
    end
end

assign mul_en_out = mul_en_out_reg[7];

// Input Registers
always @(posedge clk) begin
    if (mul_en_in) begin
        mul_a_reg <= mul_a;
        mul_b_reg <= mul_b;
    end
end

// Partial Product Generation
integer i, j;
always @* begin
    for (i = 0; i < 8; i = i + 1) begin
        for (j = 0; j < 8; j = j + 1) begin
            if (mul_b_reg[j] == 1'b1) begin
                temp[i][j+i] = mul_a_reg[i];
            end else begin
                temp[i][j+i] = 0;
            end
        end
    end
end

// Partial Sum Calculation
always @(posedge clk) begin
    if (rst_n == 0) begin
        for (i = 0; i < 8; i = i + 1) begin
            sum[i] <= 0;
        end
    end else begin
        for (i = 0; i < 8; i = i + 1) begin
            if (mul_en_in) begin
                sum[i] <= sum[i] + temp[i];
            end
        end
    end
end

// Final Product Calculation
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_out_reg <= 0;
    end else begin
        mul_out_reg <= sum[0];
        for (i = 1; i < 8; i = i + 1) begin
            mul_out_reg <= mul_out_reg + {sum[i], 8'b0};
        end
    end
end

// Output Assignment
always @* begin
    if (mul_en_out) begin
        mul_out = mul_out_reg;
    end else begin
        mul_out = 16'b0;
    end
end

endmodule