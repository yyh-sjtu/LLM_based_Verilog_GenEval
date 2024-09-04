
module TopModule (
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

// Define the states for the Lemmings finite state machine
typedef enum logic [2:0] {
    WALK_LEFT,        // Lemming is walking left
    WALK_RIGHT,       // Lemming is walking right
    FALLING,         // Lemming is falling
    DIGGING          // Lemming is digging
} State;

// Define state register and next state logic
reg [2:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

// Define outputs based on current state
always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        DIGGING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
    endcase
end

// Define next state logic based on inputs
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right && !bump_left) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (!bump_right && bump_left) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                next_state = state;
            end else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                next_state = state;
            end
        end
    endcase
end

endmodule