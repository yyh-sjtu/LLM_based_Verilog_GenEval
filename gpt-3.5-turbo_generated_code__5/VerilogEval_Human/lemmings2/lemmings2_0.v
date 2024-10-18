module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output wire walk_left,
	output wire walk_right,
	output wire aaah
);

reg [1:0] state;

always @(posedge clk or negedge areset) begin
	if (areset) begin
		state <= 2'b10; // Walk left
	else begin
		case (state)
			2'b00: // Walking left
				begin
					if (bump_right)
						state <= 2'b01; // Walk right
					else if (ground)
						state <= 2'b10; // Walk left
				end
			2'b01: // Walking right
				begin
					if (bump_left)
						state <= 2'b00; // Walk left
					else if (ground)
						state <= 2'b01; // Walk right
				end
			2'b10: // Falling
				begin
					if (ground)
						state <= state;
				end
		endcase
	end
end

assign walk_left = (state == 2'b00);
assign walk_right = (state == 2'b01);
assign aaah = (state == 2'b10);

endmodule

