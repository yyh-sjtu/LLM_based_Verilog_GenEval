module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [3:0] counter;
	reg enabled;
	
	always@(posedge clk) begin
		if(reset) begin
			counter <= 0;
			enabled <= 1;
		end
		else begin
			if(counter == 3)
				enabled <= 0;
			else if(enabled)
				counter <= counter + 1;
		end
	end
	
	assign shift_ena = enabled;
	
endmodule

