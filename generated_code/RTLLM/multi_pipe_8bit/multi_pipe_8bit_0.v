
module multi_pipe_8bit (
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

// Input Control
reg mul_en_out_reg;
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_en_out_reg <= 0;
    end else begin
        mul_en_out_reg <= mul_en_in;
    end
end

assign mul_en_out = mul_en_out_reg[7];

// Input Registers
reg [7:0] mul_a_reg;
reg [7:0] mul_b_reg;
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_a_reg <= 0;
        mul_b_reg <= 0;
    end else begin
       if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end
    end
end

// Partial Product Generation
wire [7:0] temp [7:0];
genvar i, j;
generate
    for (i = 0; i < 8; i = i + 1) begin : GEN_PART_PROD
        assign temp[i] = (mul_en_in) ? (mul_a_reg & (1 << i)) : 0;
    end
endgenerate

// Partial Sum Calculation
reg [7:0] sum [7:0];
always @(posedge clk) begin
    if (rst_n == 0) begin
        for (j = 0; j < 8; j = j + 1) begin
            sum[j] <= 0;
        end
    end else begin
        for (j = 0; j < 8; j = j + 1) begin
            if (mul_en_in) begin
                sum[j] <= sum[j] + temp[j][j];
            end
        end
    end
end

// Final Product Calculation
reg [15:0] mul_out_reg;
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_out_reg <= 0;
    end else begin
        if (mul_en_in) begin
            for (j = 0; j < 8; j = j + 1) begin
                mul_out_reg <= mul_out_reg + (sum[j] << j);
            end
        end
    end
end

// Output Assignment
always @* begin
    if (mul_en_out) begin
        mul_out = mul_out_reg;
    end else begin
        mul_out = 16'h0000;
    end
end

endmodule