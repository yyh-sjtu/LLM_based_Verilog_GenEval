module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
    
	reg [7:0] lower_byte;
	reg [7:0] upper_byte;
	reg [1:0] byteena_reg;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			lower_byte <= 8'b0;
			upper_byte <= 8'b0;
			byteena_reg <= 2'b0;
		end else begin
			if (byteena_reg[0]) lower_byte <= d[7:0];
			if (byteena_reg[1]) upper_byte <= d[15:8];
			
			byteena_reg <= byteena;
		end
	end
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			q <= 16'b0;
		end else begin
			q[7:0] <= lower_byte;
			q[15:8] <= upper_byte;
		end
	end
endmodule

