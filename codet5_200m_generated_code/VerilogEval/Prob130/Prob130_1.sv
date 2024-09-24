module TopModule (
	input [3:0] a,
	input [3:0] b,
	input [3:0] c,
	input [3:0] d,
	input [3:0] e,
	output [3:0] q
);
    always @* begin
        if (a)
            q = c;
        if (b)
            q = d;
        if (c)
            q = e;
    end
endmodule

