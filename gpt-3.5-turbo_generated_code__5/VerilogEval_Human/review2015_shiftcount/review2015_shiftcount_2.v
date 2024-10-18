module shift_register_down_counter(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] reg_data;

	always @(posedge clk) begin
		if (shift_ena == 1) begin
			reg_data <= {reg_data[2:0], data};
		end
		
		if (count_ena == 1) begin
			reg_data <= reg_data - 1;
		end
		
		if (shift_ena == 1 && count_ena == 1) begin
			reg_data <= 4'b0;
		end
	end

	assign q = reg_data;

endmodule

