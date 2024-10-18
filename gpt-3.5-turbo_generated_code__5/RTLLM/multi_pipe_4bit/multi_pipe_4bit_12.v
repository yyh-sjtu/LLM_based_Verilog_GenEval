module multi_pipe_4bit(
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 8'd0;
    end else begin
        reg [7:0] sum_reg;
        reg [7:0] partial_product;
        
        sum_reg <= 8'd0;
        
        generate
            genvar i;
            for (i = 0; i < size; i=i+1) begin
                always @* begin
                    if (mul_b[i]) begin
                        partial_product = {mul_a, {i{1'b0}}};
                    end else begin
                        partial_product = 8'd0;
                    end
                    sum_reg = sum_reg + partial_product;
                end
            end
        endgenerate
        
        mul_out <= sum_reg;
    end
end

endmodule

