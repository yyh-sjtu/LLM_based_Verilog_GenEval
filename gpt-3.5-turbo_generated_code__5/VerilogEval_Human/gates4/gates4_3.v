module and_gate (
	input [3:0] in,
	output out
);
	assign out = in[0] & in[1] & in[2] & in[3];
endmodule

module or_gate (
	input [3:0] in,
	output out
);
	assign out = in[0] | in[1] | in[2] | in[3];
endmodule

module xor_gate (
	input [3:0] in,
	output out
);
	assign out = in[0] ^ in[1] ^ in[2] ^ in[3];
endmodule

module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	and_gate and_inst (.in(in), .out(out_and));
	or_gate or_inst (.in(in), .out(out_or));
	xor_gate xor_inst (.in(in), .out(out_xor));
endmodule

