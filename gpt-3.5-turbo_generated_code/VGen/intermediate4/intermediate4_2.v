
module simple_fsm(
    input clk,
    input reset,
    input in,
    output reg out
);
    // State definitions
    parameter STATE_0 = 1'b0;
    parameter STATE_1 = 1'b1;

    // State registers
    reg present_state, next_state;

    // State transition logic
    always @(*) begin
        case (present_state)
            STATE_0: begin
                if (!in)
                    next_state = STATE_1;  // Transition to state 1
                else
                    next_state = STATE_0;  // Stay in state 0
            end
            STATE_1: begin
                if (!in)
                    next_state = STATE_0;  // Transition to state 0
                else
                    next_state = STATE_1;  // Stay in state 1
            end
            default: next_state = STATE_0;  // Default to state 0
        endcase
    end

    // State update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= STATE_0;  // Reset to state 0
        end else begin
            present_state <= next_state;  // Update state
        end
    end

    // Output logic (Moore output)
    always @(*) begin
        case (present_state)
            STATE_0: out = 1'b1;  // Output high in state 0
            STATE_1: out = 1'b0;  // Output low in state 1
            default: out = 1'bx;   // Undefined state
        endcase
    end

endmodule