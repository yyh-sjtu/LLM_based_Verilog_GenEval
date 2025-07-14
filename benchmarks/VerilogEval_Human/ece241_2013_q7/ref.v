module reference_module (
	input clk,
	input j,
	input k,
	output reg Q
);


	always @(posedge clk)
		Q <= j&~Q | ~k&Q;
	
endmodule
