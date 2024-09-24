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
    always @(posedge clk)
        if (areset)
            next_state <= INIT;
        else
            next_state <= state;
    assign walk_left = (state == INIT)? 1'b1 : 1'b0;
    assign walk_right = (state == INIT)? 1'b1 : 1'b0;
    always @(posedge clk)
        if (areset)
            next_state <= INIT;
        else
            next_state <= next_state;
    always @(posedge clk)
        if (areset)
            next_state <= INIT;
        else
            next_state <= next_state;
    always @(posedge clk)
        if (areset)
            next_state <= INIT;
        else
            next_state <= next_state;
    always @(posedge clk)
        if (areset)
            next_state <= INIT;
        else
            next_state <= next_state;
    always @(posedge clk)
        if (areset)
            next_state <= INIT;
        else
            next_state <= next_state;
endmodule

