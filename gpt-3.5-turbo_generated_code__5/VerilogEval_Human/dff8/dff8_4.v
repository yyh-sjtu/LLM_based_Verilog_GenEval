module dff (
	input clk,
	input d,
	output reg q
);

	always @(posedge clk) begin
		q <= d;
	end

endmodule

module top_module (
	input clk,
	input [7:0] d,
	output reg [7:0] q
);

	dff dff0 (.clk(clk), .d(d[0]), .q(q[0]));
	dff dff1 (.clk(clk), .d(d[1]), .q(q[1]));
	dff dff2 (.clk(clk), .d(d[2]), .q(q[2]));
	dff dff3 (.clk(clk), .d(d[3]), .q(q[3]));
	dff dff4 (.clk(clk), .d(d[4]), .q(q[4]));
	dff dff5 (.clk(clk), .d(d[5]), .q(q[5]));
	dff dff6 (.clk(clk), .d(d[6]), .q(q[6]));
	dff dff7 (.clk(clk), .d(d[7]), .q(q[7]));

endmodule

