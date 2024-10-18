module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Assign the output q based on the input values a, b, c, and d
	assign q = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (a & c) | (a & d);
endmodule

