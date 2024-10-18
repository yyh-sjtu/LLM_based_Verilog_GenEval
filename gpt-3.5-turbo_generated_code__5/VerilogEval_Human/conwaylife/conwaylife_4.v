module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			for (int i = 0; i < 256; i = i + 16) begin
				for (int j = 0; j < 16; j = j + 1) begin
					int num_neighbors = 0;

					if (q[(i + (j-1)) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end
					if (q[(i + (j+1)) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end
					if (q[((i-16) + j) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end
					if (q[((i+16) + j) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end
					if (q[((i-16) + (j-1)) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end
					if (q[((i-16) + (j+1)) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end
					if (q[((i+16) + (j-1)) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end
					if (q[((i+16) + (j+1)) % 256]) begin
						num_neighbors = num_neighbors + 1;
					end

					if (num_neighbors <= 1) begin
						next_q[i+j] <= 0;
					end else if (num_neighbors <= 3) begin
						next_q[i+j] <= q[i+j];
					end else if (num_neighbors >= 4) begin
						next_q[i+j] <= 0;
					end
				end
			end
			q <= next_q;
		end
	end

endmodule

