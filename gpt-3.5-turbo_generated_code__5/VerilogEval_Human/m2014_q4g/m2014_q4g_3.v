module xnor_gate (
	input a,
	input b,
	output xnor
);
	assign xnor = ~(a ^ b);
endmodule

module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	
	logic xnor_out;
	
	xnor_gate xnor(
		.a(in1),
		.b(in2),
		.xnor(xnor_out)
	);
	
	assign out = xnor_out ^ in3;
	
endmodule

