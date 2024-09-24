module TopModule (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
    reg [9:0] out;
    assign out_and = out;
    assign out_or = out;
    assign out_xor = out;
endmodule

