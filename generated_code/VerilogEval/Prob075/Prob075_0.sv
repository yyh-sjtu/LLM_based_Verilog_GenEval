
module TopModule (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Initialize the counter to weakly not-taken (2'b01)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment the counter, but max out at 3 (2'b11)
                    if (state < 2'b11) begin
                        state <= state + 1'b1; // Increment
                    end
                end else begin
                    // Decrement the counter, but not below 0 (2'b00)
                    if (state > 2'b00) begin
                        state <= state - 1'b1; // Decrement
                    end
                end
            end
            // If train_valid is 0, do nothing and retain the current state
        end
    end

endmodule