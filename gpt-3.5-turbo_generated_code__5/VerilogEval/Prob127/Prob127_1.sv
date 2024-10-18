
module TopModule (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define states
    typedef enum logic [1:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT
    } state_t;

    // Define state signal
    reg [1:0] state;

    // State machine logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
        end else begin
            case(state)
                STATE_WALK_LEFT: begin
                    if (bump_right) begin
                        state <= STATE_WALK_RIGHT;
                    end
                end
                STATE_WALK_RIGHT: begin
                    if (bump_left) begin
                        state <= STATE_WALK_LEFT;
                    end
                end
                default: begin
                    state <= STATE_WALK_LEFT;
                end
            endcase
        end
    end

    // Output logic
    always @* begin
        case(state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end

endmodule