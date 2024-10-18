module fsm_module (
	input x,
	output reg z
);

	// Define state types
	typedef enum logic [1:0] {
		S0,
		S1,
		S2
	} state_t;

	// Define current state and next state variables
	reg state_t current_state, next_state;

	// Assign next state based on current state and input x
	always @(current_state, x) begin
		case (current_state)
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S2; else next_state = S0;
			S2: if (x) next_state = S1; else next_state = S0;
			default: next_state = S0;
		endcase
	end

	// Assign output z based on current state
	always @(current_state) begin
		case (current_state)
			S2: z = 1;
			default: z = 0;
		endcase
	end

	// Assign current state and reset asynchronously
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end

endmodule

module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	fsm_module fsm (.x(x), .z(z));

endmodule

