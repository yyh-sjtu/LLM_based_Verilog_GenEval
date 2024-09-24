
module TopModule (
    input clk,
    input areset,
    
    // Prediction interface
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,
    
    // Training interface
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // Constants
    parameter ADDR_WIDTH = 7;
    parameter PHT_SIZE = 128;
    parameter NUM_BITS = 2; // saturating counter is 2 bits
    
    // Internal registers
    reg [ADDR_WIDTH-1:0] global_history; // Global branch history register
    reg [NUM_BITS-1:0] pht[PHT_SIZE-1:0]; // Pattern history table
    reg training_taken; // Holds the training prediction if needed
    
    // Helper function to calculate the PHT index
    function [ADDR_WIDTH-1:0] calculate_index;
        input [ADDR_WIDTH-1:0] pc;
        input [ADDR_WIDTH-1:0] history;
        begin
            calculate_index = (pc ^ history) % PHT_SIZE;
        end
    endfunction

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < PHT_SIZE; i = i + 1) begin
                pht[i] <= 2'b00; // Initialize all counters to 0
            end
        end else begin
            // Training phase
            if (train_valid) begin
                integer index = calculate_index(train_pc, train_history);
                if (train_taken) begin
                    // Increment counter on taken
                    if (pht[index] < 2'b11)
                        pht[index] <= pht[index] + 1;
                end else begin
                    // Decrement counter on not taken
                    if (pht[index] > 2'b00)
                        pht[index] <= pht[index] - 1;
                end
                
                // If it was a misprediction, recover history
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover history on misprediction
                end
            end
            
            // Prediction phase
            if (predict_valid) begin
                integer index = calculate_index(predict_pc, global_history);

                // Use current PHT state
                predict_taken <= (pht[index] >= 2'b10); // Taken if counter state is high

                // Update history on prediction
                global_history <= {global_history[5:0], predict_taken}; // Shift history left
                predict_history <= global_history; // Output current history
            end
        end
    end
endmodule