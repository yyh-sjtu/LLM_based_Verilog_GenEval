module TopModule (
	input clk,
	input reset,
	input in,
	output out
);
    parameter A = 0;
    reg [3:0] out;
    reg [4:0] state;
    assign out = state;
    always @ (posedge clk or posedge reset)
    begin
        if (reset)
            state <= A;
        else
            state <= state + 1;
    end
endmodule

