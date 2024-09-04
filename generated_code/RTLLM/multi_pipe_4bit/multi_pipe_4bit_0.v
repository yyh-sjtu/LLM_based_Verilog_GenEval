
module multi_pipe_4bit(
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_products [0:size-1];
reg [7:0] product_reg;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i = 0; i < size; i=i+1) begin
            partial_products[i] <= 8'd0;
        end
        product_reg <= 8'd0;
    end else begin
        for (int i = 0; i < size; i=i+1) begin
            if (mul_b[i] == 1) begin
                partial_products[i] <= {mul_a, {(size-1)-i{1'b0}}};
            end else begin
                partial_products[i] <= 8'd0;
            end
        end
        product_reg <= partial_products[0];
        for (int i = 1; i < size; i=i+1) begin
            product_reg <= product_reg + partial_products[i];
        end
    end
end

assign mul_out = product_reg;

endmodule