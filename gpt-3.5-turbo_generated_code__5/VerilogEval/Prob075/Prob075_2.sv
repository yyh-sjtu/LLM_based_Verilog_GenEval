
module TopModule(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

// Define internal signals
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset
        state <= 2'b01;
    end else begin
        // Saturating counter logic
        if (train_valid && train_taken && (state != 2'b11)) begin
            // Increment counter
            next_state <= state + 2'b01;
        end else if (train_valid && !train_taken && (state != 2'b00)) begin
            // Decrement counter
            next_state <= state - 2'b01;
        end else begin
            // Keep counter value unchanged
            next_state <= state;
        end
    end
end

always @(posedge clk) begin
    // Assign next state value to current state
    state <= next_state;
end

endmodule