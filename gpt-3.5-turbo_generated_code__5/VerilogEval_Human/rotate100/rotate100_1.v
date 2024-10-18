module rotator(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q
);
	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			case(ena)
				2'b01: q <= {q[99], q[98:0]};
				2'b10: q <= {q[99:1], q[0]};
				default: q <= q;
			endcase
		end
	end
endmodule

module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q
);
	rotator rot (
		.clk(clk),
		.load(load),
		.ena(ena),
		.data(data),
		.q(q)
	);
endmodule

