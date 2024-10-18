module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // reset to state A
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			2'b00: begin // State A
				if (in)
					next_state = 2'b01; // Next state in=1 is B
				else
					next_state = 2'b00; // Next state in=0 is A
				out = 1'b0; // Output is always 0 in state A
			end
			2'b01: begin // State B
				if (in)
					next_state = 2'b01; // Next state in=1 is B
				else
					next_state = 2'b10; // Next state in=0 is C
				out = 1'b0; // Output is always 0 in state B
			end
			2'b10: begin // State C
				if (in)
					next_state = 2'b11; // Next state in=1 is D
				else
					next_state = 2'b00; // Next state in=0 is A
				out = 1'b0; // Output is always 0 in state C
			end
			2'b11: begin // State D
				if (in)
					next_state = 2'b10; // Next state in=1 is C
				else
					next_state = 2'b01; // Next state in=0 is B
				out = 1'b1; // Output is always 1 in state D
			end
		endcase
	end
endmodule

