module TopModule (
	input clk,
	input reset,
	input [7:0] d,
	output [7:0] q
);
    reg [7:0] q;
    always @(posedge clk or posedge reset)
        if (reset)
            q <= 8'b0;
        else
            q <= d;
endmodule

