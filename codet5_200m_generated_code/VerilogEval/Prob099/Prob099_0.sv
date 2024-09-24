module TopModule (
	input [6:0] y,
	input w,
	output Y1,
	output Y3
);
    reg [1:0] a;
    reg [1:0] b;
    always @(y)
        if (w)
            a = 5'b00001;
        else
            a = a + 5'b001;
    assign Y1 = a[0];
    assign Y3 = a[1];
endmodule

