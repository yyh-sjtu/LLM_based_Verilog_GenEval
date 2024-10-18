module nor_gate (
	input a,
	input b,
	output logic y
);

	assign y = ~(a | b);

endmodule

module top_module (
	input in1,
	input in2,
	output logic out
);

	nor_gate nor (
		.a(in1),
		.b(in2),
		.y(out)
	);

endmodule

