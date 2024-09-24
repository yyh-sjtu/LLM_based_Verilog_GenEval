module TopModule (
	input clk,
	input areset,
	input [7:0] d,
	output [7:0] q
);
    reg [7:0] q0;
    always @(posedge clk or posedge areset)
    begin
        if (areset == 1'b0)
            q0 <= 8'b11111110;
        else
            q0 <= d;
    end
endmodule

