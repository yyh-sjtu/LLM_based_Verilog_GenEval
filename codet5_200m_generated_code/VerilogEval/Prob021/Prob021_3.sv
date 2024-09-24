module TopModule (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    wire [3:0] out = out[sel];
endmodule

