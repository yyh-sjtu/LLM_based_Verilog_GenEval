
module TopModule (
    input  clk,
    input  areset,
    input  in,
    output reg out
);

    // State definitions
    typedef enum logic {
        A, // State A (output: 0)
        B  // State B (output: 1)
    } state_t;

    // Current state and next state variables
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B; // Asynchronously reset to state B
            out <= 1;           // Output for state B is 1
        end else begin
            current_state <= next_state; // Update the state
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: begin
                if (in == 0) begin
                    next_state = B; // 0 from A goes to B
                end else begin
                    next_state = A; // 1 from A stays in A
                end
                out = 0; // Output for state A is 0
            end
            B: begin
                if (in == 0) begin
                    next_state = A; // 0 from B goes to A
                end else begin
                    next_state = B; // 1 from B stays in B
                end
                out = 1; // Output for state B is 1
            end
            default: begin
                next_state = B; // Default state
            end
        endcase
    end

endmodule