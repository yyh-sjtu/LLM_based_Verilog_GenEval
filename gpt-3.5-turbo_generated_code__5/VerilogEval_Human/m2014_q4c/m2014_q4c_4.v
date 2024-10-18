module d_flip_flop (
	input clk,
	input d,
	input r,
	output reg q
);

always @(posedge clk) begin
	if (r) begin
		q <= 1'b0;
	end else begin
		q <= d;
	end
end

endmodule

module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

d_flip_flop dff (
	.clk(clk),
	.d(d),
	.r(r),
	.q(q)
);

endmodule

