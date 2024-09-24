module TopModule (
	input clk,
	input reset,
	output [9:0] q
);
    reg [9:0] q;
    always @ (posedge clk)
    begin
        if (reset == 1)
            q <= 0;
        else
            q <= q + 1;
    end
endmodule

