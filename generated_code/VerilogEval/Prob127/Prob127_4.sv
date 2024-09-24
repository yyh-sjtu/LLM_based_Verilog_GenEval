
module TopModule (
    input  clk,
    input  areset,
    input  bump_left,
    input  bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State Transition - (in the always block that is sensitive to clock)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT; // Reset to walk left state
        end else begin
            current_state <= next_state; // Transition to the next state
        end
    end

    // Combinational logic for state transition and output
    always @(*) begin
        // Default Outputs
        walk_left = 0;
        walk_right = 0;

        // Next state logic
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1; // Current State - Walking Left

                if (bump_right || bump_left) begin
                    next_state = STATE_WALK_RIGHT; // Bumped on the left or right
                end else begin
                    next_state = STATE_WALK_LEFT; // Stay in the same state
                end
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1; // Current State - Walking Right
                
                if (bump_left || bump_right) begin
                    next_state = STATE_WALK_LEFT; // Bumped on the left or right
                end else begin
                    next_state = STATE_WALK_RIGHT; // Stay in the same state
                end
            end
            
            default: begin
                // Default case should not occur if the FSM is designed correctly.
                next_state = STATE_WALK_LEFT; // Safe fallback
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end

endmodule