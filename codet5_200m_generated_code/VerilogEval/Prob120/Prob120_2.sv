module TopModule (
	input clk,
	input reset,
	input in,
	output out
);
    reg [1:0] state;
    reg [3:0] code;
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0110;
        else
            state <= state + 1;
    end
    assign out = code;
endmodule

