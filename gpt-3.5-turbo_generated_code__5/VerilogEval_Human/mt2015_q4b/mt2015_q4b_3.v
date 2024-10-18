module top_module(
	input x,
	input y,
	output z);

	// Define the registers and wires
	reg x_reg, y_reg, z_reg;
	wire x_next, y_next, z_next;

	// Define the D flip-flops for x and y
	always @(posedge clk) begin
		x_reg <= x_next;
		y_reg <= y_next;
	end

	// Define the assignment of values to x_next and y_next
	always @(x_reg, y_reg) begin
		if(x_reg == 1'b1) 
			x_next <= 1'b0;
		else 
			x_next <= y_reg;

		if(y_reg == 1'b1) 
			y_next <= x_reg;
		else 
			y_next <= 1'b0;
	end

	// Define the logic for z
	always @(x_next, y_next) begin
		if(x_next == 1'b0 && y_next == 1'b0) 
			z_next <= 1'b1;
		else 
			z_next <= 1'b0;

	end

	// Define the assignment of values to z_reg
	always @(posedge clk) begin
		z_reg <= z_next;
	end

	// Assign the output z to z_reg	
	assign z = z_reg;

endmodule

