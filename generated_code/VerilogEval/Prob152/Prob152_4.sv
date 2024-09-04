
module TopModule(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    // State Encoding
    typedef enum reg [1:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL,
        STATE_DIG
    } state_t;

    state_t current_state, next_state;

    // State Register (Sequential Logic)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Update state
        end
    end

    // Next State and Output Logic (Combinatorial Logic)
    always @(*) begin
        // Default outputs
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                aaah = 0; // Not falling
                if (!ground) begin
                    next_state = STATE_FALL; // Fall if there is no ground
                    aaah = 1; // Say "aaah!"
                end else if (dig) begin
                    next_state = STATE_DIG; // Start digging
                    digging = 1;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT; // Bump on right
                end
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1;
                aaah = 0; // Not falling
                if (!ground) begin
                    next_state = STATE_FALL; // Fall if there is no ground
                    aaah = 1; // Say "aaah!"
                end else if (dig) begin
                    next_state = STATE_DIG; // Start digging
                    digging = 1;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT; // Bump on left
                end
            end
            
            STATE_FALL: begin
                aaah = 1; // Falling
                if (ground) begin
                    // When ground reappears, resume previous direction
                    if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT; // Back to walking left
                    end else begin
                        next_state = STATE_WALK_RIGHT; // Back to walking right
                    end
                end
            end
            
            STATE_DIG: begin
                digging = 1; // Digging
                if (!ground) begin
                    next_state = STATE_FALL; // Fall if there is no ground
                    aaah = 1; // Say "aaah!"
                end else if (bump_left || bump_right) begin
                    // Ignore bumps while digging
                    next_state = STATE_DIG; // Stay in digging state
                end
            end

            default: begin
                // Default case should not happen; includes input reset.
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end
endmodule