module TopModule (
	input clk,
	input reset,
	input [7:0] d,
	output [7:0] q
);
    reg [7:0] q_reg;
    always @(posedge clk)
        if (reset)
            q_reg <= 8'h00;
        else
            q_reg <= d;
endmodule

