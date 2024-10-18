module multi_pipe_8bit(
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
wire [7:0] temp [0:7];
reg [15:0] sum [0:7];
reg [15:0] mul_out_reg;

// Input Control
always @(posedge clk) begin
    if (~rst_n)
        mul_en_out <= 0;
    else
        mul_en_out <= mul_en_in;
end

// Input Registers
always @(posedge clk) begin
    if (~rst_n)
        mul_a_reg <= 0;
    else if (mul_en_in)
        mul_a_reg <= mul_a;
end

always @(posedge clk) begin
    if (~rst_n)
        mul_b_reg <= 0;
    else if (mul_en_in)
        mul_b_reg <= mul_b;
end

// Partial Product Generation
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : gen_pp
        assign temp[i] = mul_b_reg[i] ? mul_a_reg : 8'b0;
    end
endgenerate

// Partial Sum Calculation
genvar j;
generate
    for (j = 0; j < 8; j = j + 1) begin : gen_ps
        always @(posedge clk) begin
            if (~rst_n)
                sum[j] <= 0;
            else if (mul_en_in)
                sum[j] <= temp[j] + (j > 0 ? sum[j-1] : 0);
        end
    end
endgenerate

// Final Product Calculation
always @(posedge clk) begin
    if (~rst_n)
        mul_out_reg <= 0;
    else if (mul_en_in)
        mul_out_reg <= sum[7];
end

// Output Assignment
always @(posedge clk) begin
    if (~rst_n || ~mul_en_out)
        mul_out <= 0;
    else
        mul_out <= mul_out_reg;
end

endmodule

