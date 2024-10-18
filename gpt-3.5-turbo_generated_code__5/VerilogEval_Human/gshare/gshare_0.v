module branch_predictor(
	input clk,
	input areset, 
	
	// Prediction interface
	input predict_valid,
	input [6:0] predict_pc,
	output predict_taken, 
	output [6:0] predict_history,
	
	// Training interface
	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input [6:0] train_pc
);

	reg [HISTORY_BITS-1:0] global_history_reg;
	reg [COUNTER_SIZE-1:0] PHT[PHT_SIZE-1:0];

	// Predict
	reg [COUNTER_SIZE-1:0] prediction_counter;
	reg [HISTORY_BITS-1:0] prediction_history;
	reg predict_taken_reg;

	// Training
	reg [COUNTER_SIZE-1:0] train_counter;
	reg [HISTORY_BITS-1:0] train_history_reg;
	reg [HISTORY_BITS-1:0] train_global_history_reg;
	reg [COUNTER_SIZE-1:0] train_prediction_counter;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			global_history_reg <= 0;
			PHT <= 0;
		end else begin
			if (train_valid) begin
				// Update PHT during training
				train_counter <= PHT[train_history];
				if (train_taken) begin
					if (train_counter < 3) begin
						PHT[train_history] <= train_counter + 1;
					end
				end else begin
					if (train_counter > 0) begin
						PHT[train_history] <= train_counter - 1;
					end
				end

				// Update global history for training
				train_global_history_reg <= {global_history_reg[HISTORY_BITS-2:0], train_taken};
			end

			if (predict_valid) begin
				// Generate prediction
				prediction_counter <= PHT[predict_pc];
				prediction_history <= global_history_reg;
				if (prediction_counter < 2) begin
					predict_taken_reg <= 0;
				end else begin
					predict_taken_reg <= 1;
				end
			end

			// Update global history
			global_history_reg <= {global_history_reg[HISTORY_BITS-2:0], predict_taken_reg};
		end
	end

	assign predict_taken = predict_taken_reg;
	assign predict_history = prediction_history;

endmodule

