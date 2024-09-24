module TopModule (
	input a,
	input b,
	output out_assign,
	output out_alwaysblock
);
    assign out_assign = a & b;
    always block #1 out_alwaysblock = 1;
endmodule

