
module multi_pipe_8bit (
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

reg [7:0] mul_a_reg, mul_b_reg;
reg [15:0] mul_out_reg;
wire [15:0] temp [7:0];
reg [15:0] sum [7:0];

// Input Control
always @(posedge clk) begin
    if (!rst_n) begin
        mul_en_out <= 0;
        mul_a_reg <= 0;
        mul_b_reg <= 0;
    end else begin
        mul_a_reg <= (mul_en_in) ? mul_a : mul_a_reg;
        mul_b_reg <= (mul_en_in) ? mul_b : mul_b_reg;
        mul_en_out <= mul_en_in;
    end
end

// Partial Product Generation
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : gen_partial_prod
        assign temp[i] = (mul_b_reg[i]) ? {8'd0, mul_a_reg} : 16'd0;
    end
endgenerate

// Partial Sum Calculation
always @(posedge clk) begin
    if (!rst_n) begin
        for (i = 0; i < 8; i = i + 1) begin
            sum[i] <= 0;
        end
    end else begin
        for (i = 0; i < 8; i = i + 1) begin
            sum[i] <= sum[i] + temp[i];
        end
    end
end

// Final Product Calculation
always @(*)
begin
    for (i = 0; i < 8; i = i + 1) begin
        mul_out_reg <= mul_out_reg + sum[i];
    end
end

// Output Assignment
always @(posedge clk) begin
    if (!rst_n) begin
        mul_out <= 0;
    end else begin
        if (mul_en_out) begin
            mul_out <= mul_out_reg;
        end else begin
            mul_out <= 16'd0;
        end
    end
end

endmodule