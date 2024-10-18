module jk_flip_flop (
	input j,
	input k,
	input clk,
	output reg Q
);

	always @(posedge clk) begin
		// Check if both J and K are 0
		if (j == 0 && k == 0)
			Q <= Q; // Q remains unchanged
		
		// J is 0 and K is 1
		else if (j == 0 && k == 1)
			Q <= 0; // Q = 0
		
		// J is 1 and K is 0
		else if (j == 1 && k == 0)
			Q <= 1; // Q = 1
		
		// J and K are both 1
		else if (j == 1 && k == 1)
			Q <= ~Q; // Q = ~Q
		
	end

endmodule

