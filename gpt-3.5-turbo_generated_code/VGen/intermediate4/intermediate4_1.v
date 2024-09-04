
module simple_fsm (
    input clk,          // Clock input
    input reset,        // Reset input
    input in,           // Input signal
    output reg out      // Output signal
);
    // State encoding
    parameter STATE_0 = 1'b0; // State 0
    parameter STATE_1 = 1'b1; // State 1

    // Current state and next state registers
    reg present_state, next_state;

    // Output logic based on the present state (Moore output)
    always @(*) begin
        case (present_state)
            STATE_0: out = 1'b1; // Output high in state 0
            STATE_1: out = 1'b0; // Output low in state 1
            default: out = 1'b0; // Default case
        endcase
    end

    // State transition logic
    always @(*) begin
        case (present_state)
            STATE_0: begin
                if (~in) // If input is low, transition to next state
                    next_state = STATE_1;
                else
                    next_state = STATE_0; // Stay in same state
            end
            STATE_1: begin
                if (~in) // If input is low, stay in state 1
                    next_state = STATE_1;
                else
                    next_state = STATE_0; // Transition back to state 0
            end
            default: next_state = STATE_0; // Default to state 0
        endcase
    end

    // Sequential logic: State update on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= STATE_0; // Initialize to state 0 on reset
        end else begin
            present_state <= next_state; // Update present state
        end
    end
endmodule