module top_module(
	input x,
	input y,
	output z);

	reg x_reg;
	reg y_reg;
	reg z_reg;

	always @(posedge x or posedge y) begin
		x_reg <= #5 x;
		y_reg <= #5 y;

		case ({x_reg, y_reg})
			2'b00: z_reg <= #5 1'b1;
			2'b01: z_reg <= #5 1'b0;
			2'b10: z_reg <= #5 1'b0;
			2'b11: z_reg <= #5 1'b1;
		endcase
	end

	assign z = z_reg;

endmodule

