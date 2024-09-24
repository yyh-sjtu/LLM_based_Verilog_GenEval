module TopModule (
	input [99:0] in,
	output [99:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);
    assign out_both = in[99:0];
    assign out_any = in[99:0];
    assign out_different = in[99:0];
endmodule

