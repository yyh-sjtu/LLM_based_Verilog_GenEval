module TopModule (
	input clk,
	input ar,
	input d,
	output q
);
    reg [8:0] q;
    always @(posedge clk or posedge ar)
        if (ar)
            q <= 8'b0;
        else if (d)
            q <= d;
endmodule

