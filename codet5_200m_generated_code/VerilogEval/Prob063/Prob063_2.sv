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
            q <= {q[0], data};
        else if (count_ena)
            q <= {q[1], data};
    assign q = q[3:0];
endmodule

