module synchronizer (
	input clk_a, // Clock signal A
	input clk_b, // Clock signal B
	input arstn, // Active-low reset signal A
	input brstn, // Active-low reset signal B
	input [3:0] data_in, // Input data signal
	input data_en, // Input enable signal
	output reg [3:0] dataout // Output data signal
);

	reg [3:0] data_reg; // Data register
	reg en_data_reg; // Enable data register
	reg en_clap_one; // Enable control register 1
	reg en_clap_two; // Enable control register 2

	// Data Register
	always @(posedge clk_a or negedge arstn) begin
		if (~arstn) begin
			data_reg <= 4'd0; // Reset condition
		end else begin
			data_reg <= data_in; // Update with input data signal
		end
	end

	// Enable Data Register
	always @(posedge clk_a or negedge arstn) begin
		if (~arstn) begin
			en_data_reg <= 1'b0; // Reset condition
		end else begin
			en_data_reg <= data_en; // Update with input enable signal
		end
	end

	// Enable Control Registers
	always @(posedge clk_b or negedge brstn) begin
		if (~brstn) begin
			en_clap_one <= 1'b0; // Reset condition
			en_clap_two <= 1'b0; // Reset condition
		end else begin
			en_clap_one <= en_data_reg; // Assign value of enable data register
			en_clap_two <= en_clap_one; // Assign previous value of enable control register 1
		end
	end

	// Output Assignment
	always @(posedge clk_b or negedge brstn) begin
		if (~brstn) begin
			dataout <= 4'd0; // Reset condition
		end else begin
			if (en_clap_two) begin
				dataout <= data_reg; // Assign value of data register
			end
			// If enable control register 2 is inactive, dataout retains its previous value
		end
	end

endmodule

