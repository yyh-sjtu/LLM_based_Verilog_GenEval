module multi_pipe_8bit (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

reg [7:0] mul_a_reg;
reg [7:0] mul_b_reg;

wire [15:0] temp;
reg [15:0] sum_1, sum_2, sum_3, sum_4, sum_5, sum_6, sum_7, sum_8, mul_out_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        mul_en_out <= 0;
        mul_a_reg <= 8'b0;
        mul_b_reg <= 8'b0;
        sum_1 <= 16'b0;
        sum_2 <= 16'b0;
        sum_3 <= 16'b0;
        sum_4 <= 16'b0;
        sum_5 <= 16'b0;
        sum_6 <= 16'b0;
        sum_7 <= 16'b0;
        sum_8 <= 16'b0;
        mul_out_reg <= 16'b0;
    end else begin
        mul_en_out <= mul_en_in;
        if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
            temp[0] <= mul_a_reg[0] & mul_b_reg;
            temp[1] <= mul_a_reg[1] & mul_b_reg;
            // ... continue for all bits
            
            sum_1 <= temp[0];
            sum_2 <= sum_1 + (temp[1] << 1);
            // ... continue for all partial sums
            
            mul_out_reg <= sum_8;
        end
    end
end

assign mul_out = (mul_en_out) ? mul_out_reg : 16'b0;

endmodule

