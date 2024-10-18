module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [3:0] count;
	reg shift_enable;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 0;
			shift_enable <= 1;
		end
		else begin
			if (count < 4) begin
				count <= count + 1;
				shift_enable <= 1;
			end
			else begin
				count <= 0;
				shift_enable <= 0;
			end
		end
	end
	
	assign shift_ena = shift_enable;
endmodule

