module multi_pipe_8bit (
    input  wire         clk,
    input  wire         rst_n,
    input  wire         mul_en_in,
    input  wire  [7:0]  mul_a,
    input  wire  [7:0]  mul_b,
    output reg          mul_en_out,
    output reg  [15:0]  mul_out
);

reg         mul_en_out_reg;
reg  [7:0] mul_a_reg;
reg  [7:0] mul_b_reg;
wire [7:0] temp [7:0];
reg  [15:0] sum [7:0];
reg  [15:0] mul_out_reg;

always @(posedge clk) begin
    if (!rst_n) begin
        mul_en_out_reg <= 1'b0;
        mul_a_reg <= 8'b0;
        mul_b_reg <= 8'b0;
        for (int i = 0; i < 8; i=i+1) begin
            temp[i] <= 8'b0;
            sum[i] <= 16'b0;
        end
        mul_out_reg <= 16'b0;
    end else begin
        mul_en_out_reg <= mul_en_in;
        if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
            for (int i = 0; i < 8; i=i+1) begin
                temp[i] <= (mul_b_reg[i]) ? mul_a_reg : 8'b0;
            end
            for (int i = 0; i < 8; i=i+1) begin
                sum[i] <= (i == 0) ? {16'b0, temp[i]} : sum[i-1] + {16'b0, temp[i]};
            end
            mul_out_reg <= sum[7];
        end
    end
end

assign mul_en_out = mul_en_out_reg;
assign mul_out = (mul_en_out_reg) ? mul_out_reg : 16'b0;

endmodule

