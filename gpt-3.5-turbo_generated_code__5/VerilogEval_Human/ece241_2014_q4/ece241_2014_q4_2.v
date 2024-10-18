
module flip_flop (
	input clk,
	input d,
	output q
);

	reg q;

	always @(posedge clk) begin
		q <= d;
	end

endmodule

module xor_gate (
	input a,
	input b,
	output c
);
	
	assign c = a ^ b;

endmodule

module and_gate (
	input a,
	input b,
	output c
);

	assign c = a & b;

endmodule

module or_gate (
	input a,
	input b,
	output c
);

	assign c = a | b;

endmodule

module xnor_gate (
	input a,
	input b,
	input c,
	output z
);

	assign z = !(a ^ b ^ c);

endmodule

module top_module (
	input clk,
	input x,
	output z
);

	reg d1, d2, d3;
	wire q1, q2, q3;

	flip_flop ff1 (.clk(clk), .d(d1), .q(q1));
	flip_flop ff2 (.clk(clk), .d(d2), .q(q2));
	flip_flop ff3 (.clk(clk), .d(d3), .q(q3));

	xor_gate xor1 (.a(x), .b(q1), .c(d1));
	and_gate and1 (.a(x), .b(~q2), .c(d2));
	or_gate or1 (.a(x), .b(~q3), .c(d3));

	xnor_gate xnor1 (.a(d1), .b(d2), .c(d3), .z(z));

endmodule