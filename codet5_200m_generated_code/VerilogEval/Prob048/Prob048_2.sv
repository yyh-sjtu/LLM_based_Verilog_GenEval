module TopModule (
	input clk,
	input d,
	input r,
	output q
);
    reg [3:0] q;
    always @(posedge clk or posedge r)
        if (r)
            q <= 1'b0;
        else
            q <= d;
endmodule

