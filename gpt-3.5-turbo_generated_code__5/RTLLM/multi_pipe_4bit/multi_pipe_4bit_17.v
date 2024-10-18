
module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_prod [0:size-1];
reg [7:0] sum_reg [0:size-1];

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        // Reset
        for (integer i=0; i<size; i=i+1) begin
            partial_prod[i] <= 8'h0;
            sum_reg[i] <= 8'h0;
        end
        mul_out <= 8'h0;
    end else begin
        // Multiplication
        for (integer i=0; i<size; i=i+1) begin
            if (mul_b[i]) begin
                partial_prod[i] <= {mul_a, {size{i{1'b0}}}};
            end else begin
                partial_prod[i] <= 8'h0;
            end
        end
        
        // Addition
        for (integer i=0; i<size; i=i+1) begin
            if (clk) begin
                if (i==0) begin
                    sum_reg[i] <= partial_prod[i];
                end else begin
                    sum_reg[i] <= sum_reg[i-1] + partial_prod[i];
                end
            end else begin
                if (i==0) begin
                    sum_reg[i] <= 8'h0;
                end else begin
                    sum_reg[i] <= sum_reg[i-1];
                end
            end
        end
        
        // Final Product Calculation
        if (clk) begin
            mul_out <= sum_reg[size-1];
        end else begin
            mul_out <= 8'h0;
        end
    end
end

endmodule