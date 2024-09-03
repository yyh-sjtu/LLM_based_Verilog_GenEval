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
reg [7:0] mul_en_out_reg;

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
    if (rst_n == 0) begin
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
    for (i = 0; i < 8; i = i + 1) begin: PPGen
        assign temp[i] = mul_b_reg[i] ? mul_a_reg : 8'b0;
    end
endgenerate

// Partial Sum Calculation
generate
    genvar j;
    for (j = 0; j < 8; j = j + 1) begin: PSCalc
        always @(posedge clk) begin
            if (rst_n == 0) begin
                sum[j] <= 16'b0;
            end else begin
                if (mul_en_in) begin
                    sum[j] <= sum[j] + {8'b0, temp[j]};
                end
            end
        end
    end
endgenerate

// Final Product Calculation
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_out_reg <= 16'b0;
    end else begin
        if (mul_en_in) begin
            mul_out_reg <= {sum[7], sum[6], sum[5], sum[4], sum[3], sum[2], sum[1], sum[0]};
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

