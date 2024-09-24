module TopModule (
	input clk,
	input reset,
	output [9:0] q
);
    reg [9:0] q;
    initial q <= 0;
    always @(posedge clk)
    begin
        if (reset)
            q <= 0;
        else
            q <= q + 1;
    end
endmodule

