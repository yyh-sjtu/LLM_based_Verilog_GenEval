module TopModule (
	input clk,
	input reset,
	output [3:0] ena,
	output [15:0] q
);
    reg [3:0] count;
    always @(posedge clk or posedge reset)
        if (reset)
            count <= 0;
        else
            count <= count + 1;
    assign ena = count[3];
    assign q = count[2:0];
endmodule

