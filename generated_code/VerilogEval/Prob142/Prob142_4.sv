
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

// State definition
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALLING
} State;

// State and output registers
reg [1:0] state, next_state;
reg next_walk_left, next_walk_right, next_aaah;

// State machine logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end else begin
        state <= next_state;
        walk_left <= next_walk_left;
        walk_right <= next_walk_right;
        aaah <= next_aaah;
    end
end

// Next state logic
always @* begin
    next_state = state;
    next_walk_left = walk_left;
    next_walk_right = walk_right;
    next_aaah = aaah;

    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
                next_walk_left = 0;
                next_walk_right = 1;
            end else if (!ground) begin
                next_state = FALLING;
                next_aaah = 1;
            end
        end

        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
                next_walk_left = 1;
                next_walk_right = 0;
            end else if (!ground) begin
                next_state = FALLING;
                next_aaah = 1;
            end
        end

        FALLING: begin
            if (ground) begin
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                next_aaah = 0;
            end
        end
    endcase
end

endmodule