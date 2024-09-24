
module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_products [0:size-1];
reg [7:0] mult_accumulator;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i = 0; i < size; i++) begin
            partial_products[i] <= 8'h0;
        end
        mult_accumulator <= 8'h0;
    end else begin
        for (int i = 0; i < size; i++) begin
            if (mul_b[i] == 1) begin
                partial_products[i] <= {mul_a, {size{1'b0}}} << i;
            end else begin
                partial_products[i] <= 8'h0;
            end
        end

        for (int i = 0; i < size; i++) begin
            mult_accumulator <= mult_accumulator + partial_products[i];
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 8'h0;
    end else begin
        mul_out <= mult_accumulator;
    end
end

endmodule