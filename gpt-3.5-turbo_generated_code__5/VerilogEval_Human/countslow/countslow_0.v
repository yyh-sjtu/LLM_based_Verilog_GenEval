module decade_counter(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 4'b0000;
		else if (slowena)
			q <= q + 1;
	end

endmodule

module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	decade_counter counter(
		.clk(clk),
		.slowena(slowena),
		.reset(reset),
		.q(q)
	);

endmodule

