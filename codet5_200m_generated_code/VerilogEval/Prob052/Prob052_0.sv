module TopModule (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
    wire [9:0] out_t;
    assign out_t = in[99:100];
    assign out_xor = in[99] ^ in[95];
endmodule

