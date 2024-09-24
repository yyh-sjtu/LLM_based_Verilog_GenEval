
module TopModule (
    input  clk,
    input  areset,
    input  bump_left,
    input  bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Declare state encoding
    typedef enum reg [1:0] {
        WALK_LEFT   = 2'b00,
        WALK_RIGHT  = 2'b01
    } state_t;

    // State and next state variables
    state_t current_state, next_state;

    // State register (Sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT; // Reset to WALK_LEFT state
        else
            current_state <= next_state; // Update to next state
    end

    // Next state logic (Combinational logic)
    always @(*) begin
        // Default case to hold the current state
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;

        case (current_state)
            WALK_LEFT: begin
                // If bumped left, go right
                if (bump_right) begin
                    next_state = WALK_LEFT; // Remain in WALK_LEFT unless bumped
                end
                if (bump_left) begin
                    next_state = WALK_RIGHT; // Switch to WALK_RIGHT
                end
                walk_left = 1; // Output for WALK_LEFT state
            end

            WALK_RIGHT: begin
                // If bumped right, go left
                if (bump_left) begin
                    next_state = WALK_RIGHT; // Remain in WALK_RIGHT unless bumped
                end
                if (bump_right) begin
                    next_state = WALK_LEFT; // Switch to WALK_LEFT
                end
                walk_right = 1; // Output for WALK_RIGHT state
            end

            default: begin
                next_state = WALK_LEFT; // Default state
                walk_left = 1; // Default output
            end
        endcase
    end

endmodule