module and_gate_100 (
	input [99:0] in,
	output out
);
	assign out = &in;
endmodule

module or_gate_100 (
	input [99:0] in,
	output out
);
	assign out = |in;
endmodule

module xor_gate_100 (
	input [99:0] in,
	output out
);
	assign out = ^in;
endmodule

module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	wire out_and_wire, out_or_wire, out_xor_wire;
	
	and_gate_100 and_gate_inst (
		.in(in),
		.out(out_and_wire)
	);
	
	or_gate_100 or_gate_inst (
		.in(in),
		.out(out_or_wire)
	);
	
	xor_gate_100 xor_gate_inst (
		.in(in),
		.out(out_xor_wire)
	);
	
	assign out_and = out_and_wire;
	assign out_or = out_or_wire;
	assign out_xor = out_xor_wire;
endmodule

