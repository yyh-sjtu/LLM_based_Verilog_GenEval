module TopModule (
	input clk,
	input reset,
	input [7:0] d,
	output [7:0] q
);
    reg [7:0] q;
    initial q = 0;
    always @(negedge clk)
    begin
        if (reset)
            q <= 0;
        else
            q <= {q[7], q[6:0]};
    end
endmodule

