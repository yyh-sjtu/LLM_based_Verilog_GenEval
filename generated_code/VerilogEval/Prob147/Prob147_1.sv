
module TopModule (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    // Define state transition logic based on inputs a and b
    always @(posedge clk) begin
        // Updating state based on the values of a and b
        if (a && !b) begin
            state <= 1; // Set state to 1 when a is high and b is low
        end else if (!a && b) begin
            state <= 0; // Reset state when a is low and b is high
        end else if (a && b) begin
            state <= 1; // Keep state high when both a and b are high
        end // else, retain previous state (when both a and b are low)

        // Define q based on the state
        q <= state;
    end

endmodule