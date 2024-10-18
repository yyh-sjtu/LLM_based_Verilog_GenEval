module nor_gate (
	input a,
	input b,
	output y
);

	assign y = ~(a | b);
	
endmodule

module top_module (
	input in1,
	input in2,
	output logic out
);
	
	nor_gate nor1 (
		.a(in1),
		.b(in2),
		.y(out)
	);
	
endmodule

