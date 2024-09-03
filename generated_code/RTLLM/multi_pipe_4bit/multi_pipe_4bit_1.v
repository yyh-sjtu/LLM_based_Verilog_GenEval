module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [3:0] ext_mul_a;
reg [3:0] ext_mul_b;
reg [7:0] partial_products [0:size-1];
reg [7:0] registers [0:size-1];

// Extend input signals
always @* begin
    ext_mul_a = {4'b0, mul_a};
    ext_mul_b = {4'b0, mul_b};
end

// Multiplication operation
generate
    genvar i;
    for (i = 0; i < size; i = i + 1) begin: MULTIPLY
        always @* begin
            if (ext_mul_b[i] == 1'b1)
                partial_products[i] = ext_mul_a << i;
            else
                partial_products[i] = 8'b0;
        end
    end
endgenerate

// Add of partial products
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        registers <= {size{8'b0}};
    end else begin
        registers <= registers + partial_products;
    end
end

// Final product calculation
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 8'b0;
    end else begin
        mul_out <= registers;
    end
end

endmodule

