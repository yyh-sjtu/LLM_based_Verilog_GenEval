module pe (
	input clk,
	input rst,
	input [31:0] a,
	input [31:0] b,
	output [31:0] c
);
    reg [31:0] a_reg, b_reg;
    reg [31:0] c_reg;
    always @(posedge clk) begin
        if (rst) begin
            a_reg <= 32'h0;
            b_reg <= 32'h0;
            c_reg <= 32'h0;
        end else begin
            a_reg <= a;
            b_reg <= b;
            c_reg <= c_reg;
        end
    end
endmodule

