module mux (
	input [4:0] a,
	input [4:0] b,
	input sel,
	output [4:0] out
);
    assign out = sel? a : b;
endmodule

