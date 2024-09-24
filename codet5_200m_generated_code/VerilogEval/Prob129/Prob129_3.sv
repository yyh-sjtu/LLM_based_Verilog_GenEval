module TopModule (
	input clk,
	input aresetn,
	input x,
	output z
);
    reg [3:0] state;
    reg [2:0] next_state;
    always @(posedge clk or negedge aresetn)
    begin
        if (!aresetn)
            state <= 3'b000;
        else
            state <= next_state;
    end
    assign z = state == 3'b010;
endmodule

