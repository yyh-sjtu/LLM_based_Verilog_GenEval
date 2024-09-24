module TopModule (
	input clk,
	input reset,
	input [7:0] d,
	output [7:0] q
);
    reg [7:0] q;
    always @(negedge clk, posedge reset)
    begin
        q[0] <= reset;
        q[1] <= reset;
        q[2] <= reset;
        q[3] <= reset;
        q[4] <= reset;
        q[5] <= reset;
        q[6] <= reset;
        q[7] <= reset;
    end
endmodule

