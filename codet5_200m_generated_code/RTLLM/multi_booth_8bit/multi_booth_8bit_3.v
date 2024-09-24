module multi_booth_8bit (
	input clk,
	input reset,
	input [7:0] a,
	input [7:0] b,
	output [15:0] p,
	output rdy
);
    reg [15:0] a_reg;
    reg [15:0] b_reg;
    reg rdy_reg;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_reg <= 8'b0;
            b_reg <= 8'b0;
        end else begin
            if (a_reg[7] == 1'b1) begin
                a_reg <= a;
                b_reg <= b;
            end else begin
                a_reg <= a_reg + 1;
                b_reg <= b_reg + 1;
            end
        end
    end
    assign rdy = rdy_reg;
    assign p = a_reg * b_reg;
endmodule

