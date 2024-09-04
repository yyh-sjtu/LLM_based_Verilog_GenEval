
module serial2parallel (
	input clk,
	input rst_n,
	input din_serial,
	input din_valid,
	output reg [7:0] dout_parallel,
	output reg dout_valid
);

	reg [3:0] cnt;

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 4'b0000;
			dout_valid <= 0;
			dout_parallel <= 8'b00000000;
		end else begin
			if (din_valid) begin
				if (cnt < 8) begin
					dout_parallel[cnt] <= din_serial;
					cnt <= cnt + 1;
				end
			
				if (cnt == 8) begin
					dout_valid <= 1;
				end
			end
		end
	end

endmodule