
module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	parameter START = 2'd0;
	parameter ZERO = 2'd1;
	parameter ONE = 2'd2;
	parameter TWO = 2'd3;
	parameter THREE = 2'd4;
	parameter FOUR = 2'd5;
	parameter ERROR = 2'd6;

	reg [1:0] state, next_state;

	always @(posedge clk) begin
		if (reset) begin
			state <= START;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		case(state)
			START: begin
				if (in) begin
					next_state = ONE;
				end else begin
					next_state = START;
				end
			end
			ZERO: begin
				if (in) begin
					next_state = ONE;
				end else begin
					next_state = ZERO;
				end
			end
			ONE: begin
				if (in) begin
					next_state = TWO;
				end else begin
					next_state = ZERO;
				end
			end
			TWO: begin
				if (in) begin
					next_state = THREE;
				end else begin
					next_state = ZERO;
				end
			end
			THREE: begin
				if (in) begin
					next_state = FOUR;
				end else begin
					next_state = ZERO;
				end
			end
			FOUR: begin
				if (in) begin
					next_state = ERROR;
				end else begin
					next_state = ZERO;
				end
			end
			ERROR: begin
				next_state = START;
			end
		endcase
	end

	assign disc = (state == FOUR);
	assign flag = (state == TWO);
	assign err = (state == ERROR);
endmodule