module TopModule (
	input clk,
	input reset,
	input x,
	output z
);
    reg [1:0] state;
    always @(posedge clk or posedge reset)
        if (reset)
            state <= 0;
        else
            state <= state + 1;
    assign z = state[2];
endmodule

