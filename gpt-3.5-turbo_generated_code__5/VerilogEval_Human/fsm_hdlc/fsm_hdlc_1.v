
module hdlc_fsm (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// State definitions
	parameter IDLE = 2'b00;
	parameter LOOK_FOR_FLAG = 2'b01;
	parameter LOOK_FOR_ERR = 2'b10;
	
	reg [1:0] state_next, state_reg;
	reg [2:0] count;

	always @(posedge clk) begin
		if(reset) begin
			state_reg <= IDLE;
			count <= 3'b0;
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end else begin
			state_reg <= state_next;
			case(state_reg)
				IDLE: begin
					if(in) begin
						state_next <= LOOK_FOR_FLAG;
						count <= count + 1;
					end else begin
						state_next <= IDLE;
						count <= 3'b0;
					end
				end
				LOOK_FOR_FLAG: begin
					if(in) begin
						if(count == 3'b1) begin
							count <= count + 1;
						end else if(count == 3'b111) begin
							state_next <= LOOK_FOR_ERR;
							count <= count + 1;
						end else begin
							state_next <= LOOK_FOR_FLAG;
							count <= count + 1;
						end
					end else begin
						if(count == 3'b111) begin
							state_next <= IDLE;
							count <= 3'b0;
						end else begin
							state_next <= IDLE;
							count <= 3'b0;
						end
					end
				end
				LOOK_FOR_ERR: begin
					if(in) begin
						if(count == 3'b111) begin
							err <= 1'b1;
						end
						state_next <= LOOK_FOR_ERR;
						count <= count + 1;
					end else begin
						state_next <= IDLE;
						count <= 3'b0;
					end
				end
			endcase
		end
	end

	assign disc = (state_reg == LOOK_FOR_FLAG && count == 3'b111) ? 1'b1 : 1'b0;
	assign flag = (state_reg == LOOK_FOR_FLAG && count == 3'b1111) ? 1'b1 : 1'b0;

endmodule

module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	hdlc_fsm fsm (
		.clk(clk),
		.reset(reset),
		.in(in),
		.disc(disc),
		.flag(flag),
		.err(err)
	);

endmodule