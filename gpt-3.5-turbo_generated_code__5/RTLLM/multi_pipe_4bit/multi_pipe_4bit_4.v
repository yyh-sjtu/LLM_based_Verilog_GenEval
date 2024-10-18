module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_products [3:0];
reg [7:0] intermediate_sums [1:0];

always @ (posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        for (int i=0; i<4; i=i+1) begin
            partial_products[i] <= 8'b0;
        end
        intermediate_sums[0] <= 8'b0;
        intermediate_sums[1] <= 8'b0;
        mul_out <= 8'b0;
    end else begin
        for (int i=0; i<4; i=i+1) begin
            if (mul_b[i] == 1) begin
                partial_products[i] <= {mul_a, {i{1'b0}}};
            end else begin
                partial_products[i] <= 8'b0;
            end
        end
        intermediate_sums[0] <= partial_products[0] + partial_products[1];
        intermediate_sums[1] <= partial_products[2] + partial_products[3];
        mul_out <= intermediate_sums[0] + {intermediate_sums[1], 4'b0};
    end
end

endmodule

