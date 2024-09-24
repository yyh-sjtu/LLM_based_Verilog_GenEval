module TopModule (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
    wire [7:0] code1;
    wire [7:0] code2;
    assign Y1 = code1;
    assign Y3 = code2;
    assign code1 = y[4:1];
endmodule

