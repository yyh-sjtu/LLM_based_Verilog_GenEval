module TopModule (
	input clk,
	input areset,
	input [7:0] d,
	output [7:0] q
);
    reg [7:0] q;
    always @(posedge clk or posedge areset)
    begin
        if(areset)
            q <= 8'b00000001;
        else
            q <= d;
    end
endmodule

