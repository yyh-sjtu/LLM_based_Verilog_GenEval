
module multi_pipe_4bit (
    input wire clk,
    input wire rst_n,
    input wire [3:0] mul_a,
    input wire [3:0] mul_b,
    output wire [7:0] mul_out
);

parameter size = 4;

reg [7:0] sum_regs;
reg [7:0] partial_product;
reg [3:0] ext_mul_a, ext_mul_b;

always @(mul_a) begin
    ext_mul_a = {size{mul_a[size-1]}} + mul_a;
end

always @(mul_b) begin
    ext_mul_b = {size{mul_b[size-1]}} + mul_b;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum_regs <= 0;
    end else begin
        partial_product = ext_mul_a[size-1] ? ext_mul_b : 'd0;
        for (i = 1; i < size; i = i + 1) begin
            if (ext_mul_a[size-i-1]) begin
                partial_product = {partial_product[size-1:0], 'd0} + (ext_mul_b << i);
            end
        end
        sum_regs <= sum_regs + partial_product;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 0;
    end else begin
        mul_out <= sum_regs;
    end
end

endmodule