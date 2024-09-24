module TopModule (
	input clk,
	input areset,
	input in,
	output out
);
    reg [1:0] state;
    reg [1:0] next_state;
    always @(posedge clk or posedge areset)
        if (areset)
            state <= 0;
        else
            state <= next_state;
    assign out = state[1];
endmodule

