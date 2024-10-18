
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

enum logic [1:0] {WALK_LEFT, WALK_RIGHT, FALLING} state, next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    aaah = 0;
    walk_left = (state == WALK_LEFT) ? 1 : 0;
    walk_right = (state == WALK_RIGHT) ? 1 : 0;

    case(state)
        WALK_LEFT: begin
            if (bump_right && !bump_left) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALLING;
            end else begin
                next_state = WALK_LEFT;
            end
        end

        WALK_RIGHT: begin
            if (bump_left && !bump_right) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALLING;
            end else begin
                next_state = WALK_RIGHT;
            end
        end

        FALLING: begin
            if (ground) begin
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end else begin
                next_state = FALLING;
                aaah = 1;
            end
        end
    endcase
end

endmodule