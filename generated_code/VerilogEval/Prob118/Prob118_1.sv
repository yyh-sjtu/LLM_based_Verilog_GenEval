
module TopModule (
    input          clk,
    input          areset,
    input          predict_valid,
    input          predict_taken,
    input          train_mispredicted,
    input          train_taken,
    input   [31:0] train_history,
    output reg [31:0] predict_history
);

    // Asynchronous reset and always block for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the history to zero on reset
            predict_history <= 32'b0;
        end else if (train_mispredicted) begin
            // Load the history after the mispredicted branch
            predict_history <= {train_taken, train_history[31:1]};
        end else if (predict_valid) begin
            // Shift in the new prediction taken state
            predict_history <= {predict_taken, predict_history[31:1]};
        end
        // If neither a misprediction nor a prediction is happening, 
        // do nothing. The history remains unchanged.
    end

endmodule