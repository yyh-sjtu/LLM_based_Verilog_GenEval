module TopModule (
	input clk,
	input areset,
	input in,
	output out
);
    reg [1:0] state;
    always @(posedge clk or posedge areset)
        if (areset)
            state <= 4'b0000;
        else
            state <= state + 1;
    assign out = state[1];
endmodule

