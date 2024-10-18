
module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	parameter IDLE = 2'b00;
	parameter LOOKING_FOR_5_ONES = 2'b01;
	parameter LOOKING_FOR_FLAG = 2'b10;
	parameter ERROR = 2'b11;

	reg state, next_state;
	reg[2:0] ones_counter;
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			ones_counter <= 0;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		disc = 0;
		flag = 0;
		err = 0;
		next_state = state;
		
		case(state)
			IDLE:
				begin
					if (in) begin
						ones_counter <= 1;
						next_state = LOOKING_FOR_5_ONES;
					end
				end
			LOOKING_FOR_5_ONES:
				begin
					if (in) begin
						ones_counter <= ones_counter + 1;
						if (ones_counter == 5) begin
							ones_counter <= 0;
							next_state = LOOKING_FOR_FLAG;
						end
					end else begin
						ones_counter <= 0;
						next_state = IDLE;
					end
				end
			LOOKING_FOR_FLAG:
				begin
					if (in) begin
						ones_counter <= 1;
						next_state = ERROR;
					end else begin
						ones_counter <= 0;
						flag = 1;
						next_state = IDLE;
					end
				end
			ERROR:
				begin
					if (in) begin
						ones_counter <= ones_counter + 1;
						if (ones_counter >= 7) begin
							next_state = ERROR;
							err = 1;
						end
					end else begin
						ones_counter <= 0;
						next_state = IDLE;
					end
				end
		endcase
	end
endmodule