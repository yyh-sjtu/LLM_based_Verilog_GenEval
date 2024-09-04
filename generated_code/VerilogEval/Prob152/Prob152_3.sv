
module TopModule (
    input  clk,
    input  areset,
    input  bump_left,
    input  bump_right,
    input  ground,
    input  dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    // Define states
    typedef enum logic [1:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL,
        STATE_DIGGING
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Combinational logic: Determine next state
    always_comb begin
        // Default values
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1;  // Lemming says "aaah!"
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                    digging = 1; // Start digging
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1;  // Lemming says "aaah!"
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                    digging = 1; // Start digging
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALL: begin
                aaah = 1; // Lemming is falling
                if (ground) begin
                    // When the ground appears, resume walking in the last direction
                    if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT;
                    end else if (current_state == STATE_WALK_RIGHT) begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end
                // Digging and bump events do not affect falling state
            end

            STATE_DIGGING: begin
                digging = 1; // Lemming is digging
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1; // Lemming starts falling
                end
                // Bump and ground conditions do not change the state immediately while digging
            end
        endcase
    end

    // Sequential logic: Update state on clock
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Update to the next state
        end
    end

endmodule