module TopModule (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n
);
    assign out = a & b;
    assign out_n = c & d;
endmodule

