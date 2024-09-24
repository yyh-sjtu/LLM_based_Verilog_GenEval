
module TopModule (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Sequential logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Go to next state
        end
    end

    // Combinational logic for next state and outputs
    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL; // If ground is gone, fall
                    aaah = 1; // Say aaah!
                end else if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT; // Bumped, switch to walking right
                    walk_right = 1;
                end else begin
                    next_state = WALK_LEFT; // Continue walking left
                    walk_left = 1;
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL; // If ground is gone, fall
                    aaah = 1; // Say aaah!
                end else if (bump_left || bump_right) begin
                    next_state = WALK_LEFT; // Bumped, switch to walking left
                    walk_left = 1;
                end else begin
                    next_state = WALK_RIGHT; // Continue walking right
                    walk_right = 1;
                end
            end

            FALL: begin
                if (ground) begin
                    // When ground reappears, resume previous state
                    if (current_state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                        walk_left = 1;
                    end else begin // current_state == WALK_RIGHT
                        next_state = WALK_RIGHT;
                        walk_right = 1;
                    end
                end else begin
                    next_state = FALL; // Continue falling and saying aaah
                    aaah = 1;
                end
            end

            default: begin
                next_state = WALK_LEFT; // Default to walking left
            end
        endcase
    end
endmodule