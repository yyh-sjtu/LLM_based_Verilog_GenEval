module top_module(
	input a,
	input b,
	input c,
	output out
);

wire w1;
wire w2;

and_gate and1(.in1(a), .in2(~c), .out(w1));
and_gate and2(.in1(a), .in2(b), .out(w2));
or_gate or1(.in1(w1), .in2(w2), .out(out));

endmodule

module and_gate(
	input in1,
	input in2,
	output out
);

assign out = in1 & in2;

endmodule

module or_gate(
	input in1,
	input in2,
	output out
);

assign out = in1 | in2;

endmodule

