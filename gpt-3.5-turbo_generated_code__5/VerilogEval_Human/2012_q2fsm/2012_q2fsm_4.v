module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	// State enumeration
	typedef enum logic [2:0] {A, B, C, D, E, F} state_e;

	// State flip-flops
	reg state_e current_state, next_state;

	always_ff @(posedge clk or posedge reset)
	begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// State table
	always_comb
	begin
		case(current_state)
			A: if (w) next_state = B; else next_state = A;
			B: if (w) next_state = C; else next_state = D;
			C: if (w) next_state = E; else next_state = D;
			D: if (w) next_state = F; else next_state = A;
			E: if (w) next_state = E; else next_state = D;
			F: if (w) next_state = C; else next_state = D;
		endcase
	end

	// Output assignment
	always_comb
	begin
		case(current_state)
			E: z = 1;
			default: z = 0;
		endcase
	end

endmodule

