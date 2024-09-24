module TopModule (
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output [3:0] q
);
    reg [3:0] q;
    always @(posedge clk)
        if (shift_ena)
            q <= {q[3:0], 1'b0};
        else if (count_ena)
            q <= {q[3:0], 1'b0};
    assign q = q[3:0];
endmodule

