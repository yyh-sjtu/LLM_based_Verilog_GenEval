
module TopModule (
    input  clk,
    input  areset,
    input  bump_left,
    input  bump_right,
    input  ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);
    // State Encoding
    typedef enum reg [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset on 'areset'
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Update state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL; // Start falling
                    aaah = 1; // Say "aaah!"
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT; // Bumped on right
                    aaah = 0; // Not falling
                end else begin
                    next_state = STATE_WALK_LEFT; // Continue walking left
                    aaah = 0; // Not falling
                end
            end
            
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL; // Start falling
                    aaah = 1; // Say "aaah!"
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT; // Bumped on left
                    aaah = 0; // Not falling
                end else begin
                    next_state = STATE_WALK_RIGHT; // Continue walking right
                    aaah = 0; // Not falling
                end
            end
            
            STATE_FALL: begin
                if (ground) begin
                    // When ground reappears, resume last walking direction
                    if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT; // Resume walking left
                    end else begin
                        next_state = STATE_WALK_RIGHT; // Resume walking right
                    end
                    aaah = 0; // Not falling anymore
                end else begin
                    // Still falling
                    next_state = STATE_FALL;
                    aaah = 1; // Keep saying "aaah!"
                end
            end
            
            default: begin
                next_state = STATE_WALK_LEFT; // Default state
                aaah = 0; // Not falling
            end
        endcase
    end

    // Output logic
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1;  // Output to walk left
            end
            STATE_WALK_RIGHT: begin
                walk_right = 1; // Output to walk right
            end
            STATE_FALL: begin
                walk_left = 0;  // Stop walking left
                walk_right = 0; // Stop walking right
            end
        endcase
    end
endmodule