module TopModule (
	input clk,
	input reset,
	input x,
	output z
);
    reg [3:0] y;
    always @(posedge clk or posedge reset)
        if (reset)
            y <= 0;
        else
            y <= y + 1;
    assign z = y[2];
endmodule

