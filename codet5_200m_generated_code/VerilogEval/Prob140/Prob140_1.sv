module TopModule (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err
);
    parameter [1:0] INIT = 2'b00;
    reg [1:0] state;
    reg [1:0] next_state;
    always @(posedge clk)
        if (reset)
            state <= INIT;
        else
            state <= next_state;
    assign disc = state[1];
    assign flag = state[0];
    assign err = state[1];
    always @(posedge clk)
        if (reset)
            next_state <= INIT;
        else
            next_state <= next_state;
endmodule

