module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
	
	// Define internal wires
	wire [2:0] a_not, b_not;
	
	// Calculate NOT(a) and NOT(b)
	assign a_not = ~a;
	assign b_not = ~b;
	
	// Calculate bitwise-OR of a and b
	assign out_or_bitwise = a | b;
	
	// Calculate logical-OR of a and b
	assign out_or_logical = (a != 3'b000) || (b != 3'b000);
	
	// Assign inverse of b to upper half of out_not
	assign out_not[5:3] = b_not;
	
	// Assign inverse of a to lower half of out_not
	assign out_not[2:0] = a_not;
	
endmodule

