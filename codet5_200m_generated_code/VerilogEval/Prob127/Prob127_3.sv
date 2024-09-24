module TopModule (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
    parameter [1:0] INIT = 2'b00;
    parameter [1:0] STATE = INIT;
    reg [1:0] state;
    reg [1:0] next_state;
    always @(posedge clk)
        if (areset)
            state <= INIT;
        else
            state <= next_state;
    assign walk_left = state[1];
    assign walk_right = state[0];
    always @(posedge clk)
        if (areset)
            next_state <= INIT;
        else
            next_state <= next_state;
    always @(posedge clk)
        if (areset)
            next_state <= STATE;
        else
            next_state <= next_state;
    always @(posedge clk)
        if (areset)
            next_state <= STATE;
        else
            next_state <= STATE;
    always @(posedge clk)
        if (areset)
            next_state <= STATE;
        else
            next_state <= STATE;
    always @(posedge clk)
        if (areset)
            next_state <= STATE;
        else
            next_state <= STATE;
endmodule

