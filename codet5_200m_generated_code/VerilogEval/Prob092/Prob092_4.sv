module TopModule (
	input [99:0] in,
	output [99:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);
    assign out_both = in[99:2];
    assign out_any = in[10:3];
    assign out_different = in[11:10];
endmodule

