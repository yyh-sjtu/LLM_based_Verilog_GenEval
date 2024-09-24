
module TopModule (
    input clk,
    input areset,
    input in,
    output reg out
);

    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00, // State A
        B = 2'b01  // State B
    } state_t;

    // State and next state variables
    state_t current_state, next_state;

    // Asynchronous reset to state B
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B; // Reset to state B
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Next state logic for the state machine
    always_comb begin
        case (current_state)
            A: begin
                if (in == 1'b0) begin
                    next_state = B;  // A --0--> B
                end else begin
                    next_state = A;  // A --1--> A
                end
                out = 1'b0; // Output for state A
            end
            
            B: begin
                if (in == 1'b0) begin
                    next_state = A;  // B --0--> A
                end else begin
                    next_state = B;  // B --1--> B
                end
                out = 1'b1; // Output for state B
            end
            
            default: begin
                next_state = B; // Default to state B in unexpected case
                out = 1'b1;
            end
        endcase
    end

endmodule