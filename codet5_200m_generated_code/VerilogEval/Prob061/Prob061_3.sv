module TopModule (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output Q
);
    reg [n-1:0] sr;
    always @(posedge clk)
        if (w)
            sr <= {sr[n-1], R};
    assign Q = sr[n-1];
endmodule

