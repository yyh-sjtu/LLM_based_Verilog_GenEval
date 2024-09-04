
module TopModule (
    input clk,
    input areset,

    // Prediction Interface
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    // Training Interface
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // Parameters
    localparam PHT_SIZE = 128;  // 128 entries in the PHT
    localparam [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11; // Saturating counter states

    reg [1:0] PHT [0:PHT_SIZE-1]; // Pattern history table (2-bit saturating counters)
    reg [6:0] global_history;      // Global history register

    // Function to get the index into the PHT
    function [6:0] get_index;
        input [6:0] pc;
        input [6:0] gh;
        begin
            get_index = pc ^ gh; // XOR to hash PC and global history
        end
    endfunction

    // Sequential logic for updating history and PHT
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset all PHT entries to weakly taken (S1)
            integer i;
            for (i = 0; i < PHT_SIZE; i = i + 1) begin
                PHT[i] <= S1;
            end
            global_history <= 7'b0;
            predict_taken <= 1'b0;
            predict_history <= 7'b0;
        end else begin
            // Handle training if valid
            if (train_valid) begin
                // Get the index from the train PC and previous global history
                reg [6:0] train_index = get_index(train_pc, train_history);

                // Update PHT based on actual outcome
                if (train_taken && PHT[train_index] < S3) // Increment if taken
                    PHT[train_index] <= PHT[train_index] + 1;
                else if (!train_taken && PHT[train_index] > S0) // Decrement if not taken
                    PHT[train_index] <= PHT[train_index] - 1;

                // Recover global history if misprediction
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    // Update global history with the actual outcome
                    global_history <= {global_history[5:0], train_taken};
                end
            end
            
            // Handle prediction if valid and at the same time as training
            if (predict_valid) begin
                // Get the index from current predict PC and global history
                reg [6:0] pred_index = get_index(predict_pc, global_history);
                // Read current state of PHT for prediction
                predict_taken <= (PHT[pred_index] == S2 || PHT[pred_index] == S3);

                // Update predict history with current global history
                predict_history <= global_history;
                
                // If training hasn't occurred, update global history with the predicted value
                if (!train_valid) begin
                    global_history <= {global_history[5:0], predict_taken};
                end
            end
        end
    end

endmodule