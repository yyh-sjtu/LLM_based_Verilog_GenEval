module TopModule (
	input clk,
	input j,
	input k,
	output Q
);
    reg [3:0] Q;
    always @(posedge clk)
        Q <= j;
endmodule

