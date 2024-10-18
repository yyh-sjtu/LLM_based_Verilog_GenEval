module top_module(
	input clk,
	input areset, 

	input predict_valid,
	input [6:0] predict_pc,
	output predict_taken, 
	output [6:0] predict_history,

	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input [6:0] train_pc
);

	// Define constants
	parameter INDEX_BITS = 7;
	parameter PHT_SIZE = 128;
	parameter COUNTER_SIZE = 2;
	
	reg [INDEX_BITS-1:0] index;
	reg [COUNTER_SIZE-1:0] pht[PHT_SIZE];
	
	reg [6:0] branch_history;
	
	// Internal signals
	reg [COUNTER_SIZE-1:0] counter_value;
	reg [1:0] prediction;
	
	// Predict logic
	always @(posedge clk or negedge areset) begin
		if (areset) begin
			index <= 0;
			prediction <= 0;
		end else begin
			if (predict_valid) begin
				index <= predict_pc ^ branch_history;
				prediction <= pht[index];
			end
		end
	end
	
	// Train logic
	always @(posedge clk or negedge areset) begin
		if (areset) begin
			branch_history <= 0;
		end else begin
			if (train_valid) begin
				index <= train_pc ^ train_history;
				counter_value <= pht[index];
				
				if (train_mispredicted) begin
					pht[index] <= $signed(counter_value) + $signed(train_taken);
					branch_history <= train_history; // Recover branch history register
				end else begin
					pht[index] <= $signed(counter_value) + $signed(train_taken);
				end
			end
		end
	end
	
	// Output assignment
	assign predict_taken = (prediction[1] == 2'b11) ? 1'b1 : 1'b0;
	assign predict_history = branch_history;
	
endmodule

