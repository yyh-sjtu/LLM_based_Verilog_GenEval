module TopModule (
	input clk,
	input reset,
	input in,
	output out
);
    parameter A = 0, 2 = 1;
    parameter DELAY = 2;
    parameter SLEW = 3;
    parameter SLEW_IN = 4;
    reg [A-1:0] state;
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= state + 1;
        end
    end
    assign out = state == DELAY;
endmodule

