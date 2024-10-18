module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Define state enumeration
typedef enum logic [2:0] {
	IDLE,
	START_BIT,
	DATA_BITS,
	STOP_BIT
} state_t;

// Define state register and next state logic
state_t state, next_state;

// Define registers
reg [7:0] data_reg;
reg done_reg;

// Synchronous reset
always_ff @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data_reg <= 8'b0;
		done_reg <= 1'b0;
	else
		state <= next_state;
		data_reg <= (state == DATA_BITS) ? {data_reg[6:0], in} : data_reg;
		done_reg <= (state == STOP_BIT);
	end
end

// Combinational next state logic
always_comb begin
	case (state)
		IDLE: begin
			if (in == 1'b0)
				next_state = START_BIT;
			else
				next_state = IDLE;
		end
		START_BIT: begin
			next_state = DATA_BITS;
		end
		DATA_BITS: begin
			if (in == 1'b1)
				next_state = STOP_BIT;
			else
				next_state = DATA_BITS;
		end
		STOP_BIT: begin
			if (in == 1'b0)
				next_state = IDLE;
			else
				next_state = START_BIT;
		end
	endcase
end

// Output assignment
assign out_byte = data_reg;
assign done = done_reg;

endmodule

