module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	// Define the D flip-flop module
	module d_ff (
		input clr,
		input clk,
		input d,
		output reg q
	);
		
		always @(posedge clk, negedge clr)
		begin
			if (~clr)
				q <= 1'b0;
			else
				q <= d;
		end
		
	endmodule

module shift_register (
		input clr,
		input clk,
		input [3:0] d,
		output [3:0] q
	);
		
		reg [3:0] q_reg;
		
		// Instantiate the D flip-flops
		d_ff dff0 (.clr(clr), .clk(clk), .d(d[0]), .q(q_reg[0]));
		d_ff dff1 (.clr(clr), .clk(clk), .d(d[1]), .q(q_reg[1]));
		d_ff dff2 (.clr(clr), .clk(clk), .d(d[2]), .q(q_reg[2]));
		d_ff dff3 (.clr(clr), .clk(clk), .d(d[3]), .q(q_reg[3]));
		
		always @(posedge clk, negedge clr)
		begin
			if (~clr)
				q_reg <= 4'b0;
			else
				q_reg <= {q_reg[2:0], d[0]};
		end
		
	endmodule

