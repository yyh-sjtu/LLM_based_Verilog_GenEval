
module TopModule(
    input clk, 
    input areset, 
    input bump_left, 
    input bump_right, 
    input ground, 
    output reg walk_left, 
    output reg walk_right, 
    output reg aaah 
);

// Enumerated data type for states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALLING
} state_t;

// State and next state variables
state_t state, next_state;

// State machine logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT; // Reset state to WALK_LEFT
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @* begin
    case(state)
        WALK_LEFT: begin
            if (bump_left) begin
                next_state = WALK_RIGHT;
            end else if (ground == 0) begin
                next_state = FALLING;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_right) begin
                next_state = WALK_LEFT;
            end else if (ground == 0) begin
                next_state = FALLING;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                next_state = state; // Maintain current state while falling
            end else begin
                next_state = FALLING;
            end
        end
    endcase
end

// Output logic
always @* begin
    case(state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
        end
        FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
        end
    endcase
end

endmodule