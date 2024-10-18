
module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] dff_q [0:7];
	
	always @(posedge clk) begin
		if (reset) begin
			for (int i = 0; i < 8; i = i + 1) begin
				dff_q[i] <= 8'b0;
			end
		end
		else begin
			for (int i = 0; i < 8; i = i + 1) begin
				dff_q[i] <= d[i];
			end
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			q <= 8'b0;
		end
		else begin
			q <= dff_q[7];
		end
	end
	
endmodule