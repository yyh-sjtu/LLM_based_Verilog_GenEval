module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
	
	reg [3:1] state;
	
	always @(posedge clk or negedge resetn)
	begin
		if (~resetn)
			state <= 3'b000; // state A
		else
		begin
			case (state)
				3'b000: // state A
					begin
						if (r[1] && ~r[2] && ~r[3])
							state <= 3'b001; // state B
						else if (~r[1] && r[2] && ~r[3])
							state <= 3'b010; // state C
						else if (~r[1] && ~r[2] && ~r[3])
							state <= 3'b011; // state D
						else
							state <= 3'b000;
					end
					
				3'b001: // state B
					begin
						if (r[1])
							state <= 3'b001;
						else
							state <= 3'b000;
					end
					
				3'b010: // state C
					begin
						if (r[2])
							state <= 3'b010;
						else
							state <= 3'b000;
					end
					
				default: // state D
					state <= 3'b000;
			endcase
		end
	end
	
	assign g[1] = (state == 3'b001 || state == 3'b010) ? 1 : 0; // g1
	assign g[2] = (state == 3'b010) ? 1 : 0; // g2
	assign g[3] = 0; // g3 (always 0)
	
endmodule

