module TopModule (
	input [3:0] x,
	output f
);
    assign f = (x == 0)? 1'b1 : 1'b0;
endmodule

