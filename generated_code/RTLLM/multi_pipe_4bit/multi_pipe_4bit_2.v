
module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output reg [7:0] mul_out
);

parameter size = 4;

reg [7:0] reg_partial[size-1:0];

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i = 0; i < size; i = i + 1) begin
            reg_partial[i] <= 8'd0;
        end
    end
    else begin
        for (int i = 0; i < size; i = i + 1) begin
            if (mul_b[i] == 1) begin
                reg_partial[i] <= {mul_a, 4'd0} << i;
            end
        end
        
        mul_out <= reg_partial[size-1];
        for (int i = 0; i < size-1; i = i + 1) begin
            mul_out <= mul_out + reg_partial[i];
        end
    end
end

endmodule