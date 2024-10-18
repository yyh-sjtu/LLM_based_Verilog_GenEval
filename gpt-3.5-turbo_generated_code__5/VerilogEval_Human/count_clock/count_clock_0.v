
module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	reg [3:0] hours_tens, hours_ones, minutes_tens, minutes_ones, seconds_tens, seconds_ones;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hours_tens <= 4'b0001; // initialize to 12
			hours_ones <= 4'b0010;
			minutes_tens <= 4'b0000; // initialize to 00
			minutes_ones <= 4'b0000;
			seconds_tens <= 4'b0000; // initialize to 00
			seconds_ones <= 4'b0000;
			pm <= 1'b0; // initialize to AM
		end else begin
			if (ena) begin
				seconds_ones <= (seconds_ones == 4'b1001) ? 4'b0000 : seconds_ones + 1;
				if (seconds_ones == 4'b0000) begin
					minutes_ones <= (minutes_ones == 4'b1001) ? 4'b0000 : minutes_ones + 1;
					if (minutes_ones == 4'b0000) begin
						minutes_tens <= (minutes_tens == 4'b0101) ? 4'b0000 : minutes_tens + 1;
						if (minutes_tens == 4'b0000) begin
							hours_ones <= (hours_ones == 4'b1001) ? 4'b0000 : hours_ones + 1;
							if (hours_ones == 4'b0000) begin
								hours_tens <= (hours_tens == 4'b0001) ? 4'b0000 : hours_tens + 1;
								if (hours_tens == 4'b0000) begin
									hours_tens <= 4'b0001; // reset to 12 if past 12
									pm <= ~pm; // toggle AM/PM
								end
							end
						end
					end
				end
			end
		end
	end

	assign hh = {hours_tens, hours_ones};
	assign mm = {minutes_tens, minutes_ones};
	assign ss = {seconds_tens, seconds_ones};
endmodule