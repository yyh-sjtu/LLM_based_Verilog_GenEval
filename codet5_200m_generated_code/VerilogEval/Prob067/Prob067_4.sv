module TopModule (
	input clk,
	input reset,
	input slowena,
	output [3:0] q
);
    reg [3:0] count;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count + 1;
    assign q = count;
endmodule

