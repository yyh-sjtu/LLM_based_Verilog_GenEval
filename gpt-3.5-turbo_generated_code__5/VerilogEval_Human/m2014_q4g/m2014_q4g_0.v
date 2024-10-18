module xnor (
	input a,
	input b,
	output z
);
	
	assign z = ~(a ^ b);
	
endmodule

module xor (
	input a,
	input b,
	output z
);
	
	assign z = a ^ b;
	
endmodule

module top_module (
	input in1,
	input in2,
	input in3,
	output out
);
	
	wire xnor_out;
	xnor x1 (.a(in1), .b(in2), .z(xnor_out));

	xor x2 (.a(xnor_out), .b(in3), .z(out));

endmodule

