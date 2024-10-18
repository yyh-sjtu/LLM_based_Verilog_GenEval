module accu (
	input clk,
	input rst_n,
	input [7:0] data_in,
	input valid_in,
	output reg valid_out,
	output reg [9:0] data_out
);
	
	reg [7:0] data_accumulation [3:0];
	reg [3:0] data_count;

	always @ (posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			valid_out <= 0;
			data_out <= 0;
			data_count <= 0;
			data_accumulation <= 0;
		end
		else begin
			if (valid_in) begin
				data_accumulation[data_count] <= data_in;
				data_count <= data_count + 1;

				// Accumulate 4 input data and output the sum
				if (data_count == 3) begin
					data_out <= data_accumulation[0] + data_accumulation[1] + data_accumulation[2] + data_accumulation[3];
					valid_out <= 1;
				end

				// Reset the counter and data accumulation after outputting the sum
				if (data_count == 4) begin
					data_count <= 0;
					valid_out <= 0;
					data_accumulation <= 0;
				end
			end
		end
	end
endmodule

