module multi_pipe_8bit (
	input clk,
	input rst_n,
	input mul_en_in,
	input [7:0] mul_a,
	input [7:0] mul_b,
	output mul_en_out,
	output [15:0] mul_out
);
    reg [7:0] multi_a_reg;
    reg [7:0] multi_b_reg;
    reg [7:0] multi_out_reg;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            multi_a_reg <= 8'h00;
            multi_b_reg <= 8'h00;
        end
        else begin
            if (mul_en_in) begin
                multi_a_reg <= mul_a;
                multi_b_reg <= mul_b;
            end
            else begin
                multi_a_reg <= multi_a_reg + 1;
                multi_b_reg <= multi_b_reg + 1;
            end
        end
    end
    assign mul_en_out = multi_out_reg[7];
    assign mul_out = multi_out_reg[15:8];
endmodule

