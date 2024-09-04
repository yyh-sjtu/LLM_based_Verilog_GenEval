
module TopModule (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// State encoding
typedef enum reg [1:0] {
    S0 = 2'b00, // Initial state
    S1 = 2'b01, // State after receiving '1'
    S2 = 2'b10  // State after receiving '10'
} state_t;

state_t current_state, next_state;

// Sequential logic for state transition
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        current_state <= S0;  // Reset state to S0
        z <= 1'b0;            // Reset output
    end else begin
        current_state <= next_state;
    end
end

// Combinational logic for next state and output
always @(*) begin
    // Default values
    next_state = current_state;
    z = 1'b0;

    case (current_state)
        S0: begin
            if (x) begin
                next_state = S1;  // Transition to S1 on '1'
            end
        end
        
        S1: begin
            if (!x) begin
                next_state = S2;  // Transition to S2 on '0'
            end else begin
                // Stay in S1 on '1'
            end
        end

        S2: begin
            if (x) begin
                z = 1'b1;         // Output '1' on detection of '101'
                next_state = S1;  // Transition back to S1 on '1'
            end else begin
                next_state = S0;  // Transition back to S0 on '0'
            end
        end

        default: begin
            next_state = S0; // Default to reset state
        end
    endcase
end

endmodule