module TopModule (
	input clk,
	input areset,
	input x,
	output z
);
    reg [1:0] state;
    always @(posedge clk or posedge areset)
        if (areset)
            state <= 0;
        else
            state <= state + 1;
    assign z = ~x;
endmodule

