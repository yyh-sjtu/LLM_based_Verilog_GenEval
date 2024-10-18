module moore_machine (
	input clk,
	input in,
	input areset,
	output reg out
);

// State encoding
parameter B = 0;
parameter A = 1;

// State register
reg [1:0] state_reg;
always @(posedge clk or posedge areset)
begin
	if (areset)
		state_reg <= B; // Asynchronously reset to state B
	else
		case (state_reg)
			B: begin
				if (in == 0)
					state_reg <= A;
			end
			A: begin
				if (in == 0)
					state_reg <= B;
			end
		endcase
end

// Output logic
always @*
begin
	case (state_reg)
		B: out = 0;
		A: out = 1;
	endcase
end

endmodule

