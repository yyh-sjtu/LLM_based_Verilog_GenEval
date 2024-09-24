module TopModule (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
    wire [7:0] a;
    assign a = $clog2(99);
    assign out_and = a & a;
    assign out_or = a | a;
    assign out_xor = a ^ a;
endmodule

