
module TopModule (
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output reg [1:0] state
);

// State declaration
initial begin
    state = 2'b01; // Initialize to weakly not-taken
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset the counter to weakly not-taken
    end else if (train_valid) begin
        if (train_taken) begin
            // Increment state, saturate at 3
            if (state < 2'b11) begin
                state <= state + 1;
            end
        end else begin
            // Decrement state, saturate at 0
            if (state > 2'b00) begin
                state <= state - 1;
            end
        end
    end
    // Otherwise, state remains unchanged
end

endmodule