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

	reg [4:0] state;

	localparam S_WALK_LEFT = 5'b00001;
	localparam S_WALK_RIGHT = 5'b00010;
	localparam S_FALL = 5'b00100;
	localparam S_DIG = 5'b01000;
	localparam S_SPLATTER = 5'b10000;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case(state)
				S_WALK_LEFT: begin
					if (bump_right) begin
						state <= S_WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (!ground) begin
						state <= S_FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end else if (dig) begin
						state <= S_DIG;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 1;
					end
				end
				S_WALK_RIGHT: begin
					if (bump_left) begin
						state <= S_WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (!ground) begin
						state <= S_FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end else if (dig) begin
						state <= S_DIG;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 1;
					end
				end
				S_FALL: begin
					if (ground) begin
						state <= state;
						if (state == S_FALL) begin
							walk_left <= walk_left;
							walk_right <= walk_right;
							aaah <= 0;
							digging <= 0;
						end else begin
							walk_left <= walk_left;
							walk_right <= walk_right;
							aaah <= 0;
							digging <= 0;
						end
					end else if (dig) begin
						state <= S_DIG;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 1;
					end
				end
				S_DIG: begin
					if (!ground) begin
						state <= S_FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end else if (dig) begin
						state <= S_DIG;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 1;
					end
				end
				S_SPLATTER: begin
					state <= S_SPLATTER;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end
			endcase
		end
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			if (state == S_SPLATTER && ground) begin
				state <= S_WALK_LEFT;
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
		end
	end

endmodule

