
module TopModule (
    input  wire clk,
    input  wire areset,
    input  wire predict_valid,
    input  wire predict_taken,
    input  wire train_mispredicted,
    input  wire train_taken,
    input  wire [31:0] train_history,
    output reg  [31:0] predict_history
);

    // Shift register representing the 32 bits of history
    reg [31:0] history_reg;

    // Asynchronous reset and update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // On reset, clear the history register
            history_reg <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                // If a misprediction occurs, load the history register
                history_reg <= {train_taken, train_history[31:1]}; 
            end else if (predict_valid) begin
                // Shift in the new prediction
                history_reg <= {predict_taken, history_reg[31:1]};
            end
            // Note: if neither prediction nor misprediction occurs,
            // the history_reg retains its current state.
        end
    end

    // Continuous assignment to output
    always @(*) begin
        predict_history = history_reg;
    end

endmodule