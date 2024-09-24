module TopModule (
	input clk,
	input d,
	output q
);
    reg [7:0] q;
    initial q = 0;
    always @(posedge clk) q <= d;
endmodule

