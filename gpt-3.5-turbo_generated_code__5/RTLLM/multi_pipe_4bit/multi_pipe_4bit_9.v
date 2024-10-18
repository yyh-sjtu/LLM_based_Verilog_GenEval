module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_products [0:size-1];
reg [7:0] sum_registers [0:size-1];
reg [7:0] final_product;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i = 0; i < size; i=i+1) begin
            partial_products[i] <= 8'b0;
            sum_registers[i] <= 8'b0;
        end
        final_product <= 8'b0;
    end else begin
        for (int i = 0; i < size; i=i+1) begin
            if (mul_b[i] == 1) begin
                partial_products[i] <= {mul_a, {i{1'b0}}};
            end else begin
                partial_products[i] <= 8'b0;
            end
        end
        for (int i = 0; i < size; i=i+1) begin
            if (i == 0) begin
                sum_registers[i] <= partial_products[i];
            end else begin
                sum_registers[i] <= partial_products[i] + sum_registers[i-1];
            end
        end
        final_product <= sum_registers[size-1];
    end
end

assign mul_out = final_product;

endmodule

