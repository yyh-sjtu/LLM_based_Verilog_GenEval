
module TopModule(
    input  wire clk,    // Clock input
    input  wire reset,  // Active-high synchronous reset
    input  wire in,     // Input signal
    output reg  out     // Output signal
);

// State definition
typedef enum logic [1:0] {
    B, // State B
    A  // State A
} state_t;

// State registers
state_t current_state, next_state;

// Sequential logic for state transitions
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= B; // Reset to state B
    end else begin
        current_state <= next_state; // Transition to the next state
    end
end

// Combinational logic for output and next state logic
always_comb begin
    // Default values
    out = 1'b0; // Default output
    next_state = current_state; // Default next state is staying in current state
    
    case (current_state)
        B: begin
            out = 1'b1; // Output for state B
            if (in) begin
                next_state = B; // Stay in B if in=1
            end else begin
                next_state = A; // Transition to A if in=0
            end
        end
        
        A: begin
            out = 1'b0; // Output for state A
            if (in) begin
                next_state = A; // Stay in A if in=1
            end else begin
                next_state = B; // Transition to B if in=0
            end
        end
        
        default: begin
            next_state = B; // Default to state B for safety
        end
    endcase
end

endmodule