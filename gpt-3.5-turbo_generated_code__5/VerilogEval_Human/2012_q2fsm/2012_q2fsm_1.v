module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State parameters
	parameter A = 0;		// A (0)
	parameter B = 1;		// B (0)
	parameter C = 2;		// C (0)
	parameter D = 3;		// D (0)
	parameter E = 4;		// E (1)
	parameter F = 5;		// F (1)
	
	// State and next-state variables
	reg [2:0] state;
	reg [2:0] next_state;

	// Output variable
	wire z;
	
	// State transition table
	always @(*) begin
		case(state)
			A: begin
				if (w)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
			C: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end
			D: begin
				if (w)
					next_state = F;
				else
					next_state = A;
			end
			E: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end
			F: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
		endcase
	end
	
	// State flip-flop
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output assignment
	always @(state) begin
		case(state)
			E: z = 1;
			default: z = 0;
		endcase
	end	
endmodule

