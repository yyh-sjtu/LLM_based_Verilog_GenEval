module TopModule (
	input clk,
	input reset,
	input slowena,
	output [3:0] q
);
    reg [3:0] q;
    always @(posedge clk or posedge reset)
        if (reset)
            q <= 0;
        else if (slowena)
            q <= q + 1;
endmodule

