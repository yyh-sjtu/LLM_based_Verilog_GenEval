module multi_pipe_8bit (
    input clk,             // Clock signal
    input rst_n,           // Active-low reset signal
    input mul_en_in,       // Input enable signal for multiplication
    input [7:0] mul_a,     // Multiplicand
    input [7:0] mul_b,     // Multiplier
    output mul_en_out,     // Output enable signal for multiplication
    output [15:0] mul_out  // Product output
);

reg mul_en_out_reg;
reg [7:0] mul_a_reg;
reg [7:0] mul_b_reg;

wire [15:0] temp;
reg [15:0] sum [7:0];
reg [15:0] mul_out_reg;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_en_out_reg <= 0;
        mul_a_reg <= 0;
        mul_b_reg <= 0;
        mul_out_reg <= 0;
        for (integer i = 0; i < 8; i = i + 1) begin
            sum[i] <= 0;
        end
    end else begin
        mul_en_out_reg <= mul_en_in;
        if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end
        for (integer i = 0; i < 8; i = i + 1) begin
            if (mul_en_in) begin
                temp[i*2 +: 2] <= mul_a_reg << i;
                sum[i] <= sum[i] + temp[i*2 +: 2];
            end
        end
        if (mul_en_in) begin
            mul_out_reg <= sum[7];
        end
    end
end

assign mul_en_out = mul_en_out_reg;
assign mul_out = (mul_en_out && mul_en_in) ? mul_out_reg : 16'b0;

endmodule

