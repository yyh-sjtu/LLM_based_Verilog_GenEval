module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the state enumeration
	typedef enum logic [1:0] {B, A} state_type;

	// Define the state register and next state register
	reg state_type current_state, next_state;

	// Define the output wire
	wire out;

	// Define the synchronous process to update the state
	always @(posedge clk) begin
		if (reset)
			current_state <= B;
		else
			current_state <= next_state;
	end

	// Define the combinational logic to compute the next state and output
	always @(*) begin
		case (current_state)
			B:
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 1;

			A:
				if (in)
					next_state = A;
				else
					next_state = B;
				out = 0;
		endcase
	end

	// Assign the output wire to the output port
	assign out = out;

endmodule

