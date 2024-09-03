
module multi_pipe_4bit (
    input wire clk,
    input wire rst_n,
    input wire [3:0] mul_a,
    input wire [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_prods [0:size-1];
reg [7:0] sum_reg;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i = 0; i < size; i = i + 1) begin
            partial_prods[i] <= 8'h00;
        end
        sum_reg <= 8'h00;
    end else begin
        for (int i = 0; i < size; i = i + 1) begin
            if (mul_b[i] == 1'b1) begin
                partial_prods[i] <= {mul_a, {i{1'b0}}};
            end else begin
                partial_prods[i] <= 8'h00;
            end
        end
        
        sum_reg <= 8'h00;
        for (int i = 0; i < size; i = i + 1) begin
            sum_reg <= sum_reg + partial_prods[i];
        end
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 8'h00;
    end else begin
        mul_out <= sum_reg;
    end
end

endmodule