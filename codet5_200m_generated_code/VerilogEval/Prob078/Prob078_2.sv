module TopModule (
	input clk,
	input d,
	output q
);
    reg [3:0] c;
    always @(posedge clk) c <= d;
    assign q = c[3];
endmodule

