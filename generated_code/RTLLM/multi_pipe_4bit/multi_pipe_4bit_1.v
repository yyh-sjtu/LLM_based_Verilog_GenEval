
module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_products[size-1:0];
reg [7:0] sum_reg;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum_reg <= 8'b0;
        for (int i=0; i<size; i=i+1) begin
            partial_products[i] <= 8'b0;
        end
    end
    else begin
        sum_reg <= sum_reg + partial_products[0];
        for (int i=0; i<size-1; i=i+1) begin
            partial_products[i] <= partial_products[i+1];
        end
        partial_products[size-1] <= 8'b0;
    end
end

always @(*) begin
    for (int i=0; i<size; i=i+1) begin
        if (mul_b[i] == 1) begin
            partial_products[i] <= {mul_a, i{1'b0}};
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 8'b0;
    end
    else begin
        mul_out <= sum_reg;
    end
end

endmodule