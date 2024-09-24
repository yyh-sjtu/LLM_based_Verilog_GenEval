module TopModule (
	input clk,
	input areset,
	input in,
	output out
);
    parameter [0:0] INIT = 1'b0;
    parameter [0:0] WAIT = 1'b1;
    reg [0:0] state;
    reg [0:0] next_state;
    always @(posedge clk or posedge areset)
        if (areset)
            state <= INIT;
        else
            state <= next_state;
    assign out = state;
endmodule

