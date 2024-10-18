
module population_count (
	input [2:0] in,
	output [1:0] out
);

assign out[0] = in[0] ^ in[1] ^ in[2];
assign out[1] = in[0] & in[1] | in[1] & in[2] | in[0] & in[2];

endmodule

module top_module (
	input [2:0] in,
	output [1:0] out
);

population_count pc (
	.in(in),
	.out(out)
);

endmodule