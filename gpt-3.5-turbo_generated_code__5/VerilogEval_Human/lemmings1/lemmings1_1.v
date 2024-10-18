module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define state enum
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT
	} state_t;
	
	// Define state register and next state
	reg state_t curr_state, next_state;
	
	// Define output registers
	reg walk_left_reg, walk_right_reg;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= WALK_LEFT;
			walk_left_reg <= 1'b1;
			walk_right_reg <= 1'b0;
		end else begin
			curr_state <= next_state;
			walk_left_reg <= walk_left_reg;
			walk_right_reg <= walk_right_reg;
		end
	end
	
	always @(*) begin
		case (curr_state)
			WALK_LEFT: begin
				if (bump_left) begin
					next_state = WALK_RIGHT;
					walk_left_reg = 1'b0;
					walk_right_reg = 1'b1;
				end else if (bump_right) begin
					next_state = WALK_LEFT;
					walk_left_reg = 1'b1;
					walk_right_reg = 1'b0;
				end else begin
					next_state = WALK_LEFT;
					walk_left_reg = 1'b1;
					walk_right_reg = 1'b0;
				end
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state = WALK_RIGHT;
					walk_left_reg = 1'b0;
					walk_right_reg = 1'b1;
				end else if (bump_right) begin
					next_state = WALK_LEFT;
					walk_left_reg = 1'b1;
					walk_right_reg = 1'b0;
				end else begin
					next_state = WALK_RIGHT;
					walk_left_reg = 1'b0;
					walk_right_reg = 1'b1;
				end
			end
			
			default: begin
				next_state = WALK_LEFT;
				walk_left_reg = 1'b1;
				walk_right_reg = 1'b0;
			end
		endcase
	end
	
	assign walk_left = walk_left_reg;
	assign walk_right = walk_right_reg;

endmodule

