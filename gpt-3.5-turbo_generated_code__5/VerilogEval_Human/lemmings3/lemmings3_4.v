
module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);
	
	// Define states
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALL = 2'b10;
	parameter DIG = 2'b11;
	
	// Define next state logic
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end
		else begin
			case({walk_left, walk_right, ground, dig})
				WALK_LEFT: begin
					if (bump_left && !bump_right)
						walk_left <= 0;
					else if (!bump_left && bump_right)
						walk_right <= 1;
					else if (!ground)
						walk_left <= 0;
					else if (dig)
						walk_left <= 0;
				end
				
				WALK_RIGHT: begin
					if (!bump_left && bump_right)
						walk_right <= 0;
					else if (bump_left && !bump_right)
						walk_left <= 1;
					else if (!ground)
						walk_right <= 0;
					else if (dig)
						walk_right <= 0;
				end
				
				FALL: begin
					aaah <= 1;
					if (ground)
						if (walk_left == 1)
							walk_left <= 0;
						else
							walk_right <= 0;
				end
				
				DIG: begin
					aaah <= 0;
					digging <= 1;
					if (!ground || (bump_left && !bump_right) || (!bump_left && bump_right))
						digging <= 0;
				end
			endcase
		end
	end
	
endmodule