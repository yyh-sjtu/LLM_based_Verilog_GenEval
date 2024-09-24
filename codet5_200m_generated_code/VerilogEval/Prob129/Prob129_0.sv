module TopModule (
	input clk,
	input aresetn,
	input x,
	output z
);
    reg [2:0] state, nextstate;
    always @(posedge clk or negedge aresetn)
        if (~aresetn) begin
            state <= 2'b01;
            nextstate <= 2'b00;
        end else begin
            state <= nextstate;
            nextstate <= nextstate;
        end
    assign z = state == 2'b00;
endmodule

