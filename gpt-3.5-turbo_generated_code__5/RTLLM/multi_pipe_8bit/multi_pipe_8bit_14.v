
module multi_pipe_8bit (
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output mul_en_out,
    output [15:0] mul_out
);

reg [7:0] mul_a_reg;
reg [7:0] mul_b_reg;

wire [7:0] temp [7:0];
reg [15:0] sum [7:0];
reg [15:0] mul_out_reg;

reg mul_en_out_reg;

// Input Control
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_en_out_reg <= 1'b0;
    end else begin
        mul_en_out_reg <= mul_en_in;
    end
end

assign mul_en_out = mul_en_out_reg[7];

// Input Registers
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_a_reg <= 8'b0;
        mul_b_reg <= 8'b0;
    end else begin
        if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end
    end
end

// Partial Product Generation
generate
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin: GEN_PARTIAL_PRODUCTS
        assign temp[i] = (mul_en_in) ? mul_a_reg & mul_b_reg[i] : 8'b0;
    end
endgenerate

// Partial Sum Calculation
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        foreach (sum[index]) begin
            sum[index] <= 16'b0;
        end
    end else begin
        if (mul_en_in) begin
            foreach (sum[index]) begin
                if (index == 0) begin
                    sum[index] <= temp[index];
                end else begin
                    sum[index] <= sum[index-1] + temp[index];
                end
            end
        end
    end
end

// Final Product Calculation
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out_reg <= 16'b0;
    end else begin
        if (mul_en_in) begin
            mul_out_reg <= sum[7];
        end
    end
end

// Output Assignment
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 16'b0000_0000_0000_0000;
    end else begin
        if (mul_en_out) begin
            mul_out <= mul_out_reg;
        end else begin
            mul_out <= 16'b0000_0000_0000_0000;
        end
    end
end

endmodule