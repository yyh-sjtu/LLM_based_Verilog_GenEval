module TopModule (
	input a,
	input b,
	output out
);
    wire [4:0] in_code;
    wire out_code;
    assign out = out_code | in_code;
endmodule

