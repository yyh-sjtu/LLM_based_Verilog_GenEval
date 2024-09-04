
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

    // State encoding
    typedef enum reg [2:0] {
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALLING = 3'b010,
        STATE_DIGGING = 3'b011,
        STATE_SPLATTER = 3'b100
    } state_t;

    reg [2:0] state, next_state;
    reg [4:0] fall_counter; // Counter for fall duration

    // Sequential Logic: state transition on clock
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Combinatorial Logic: next state & outputs
    always @* begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        next_state = state; // Hold current state by default
        fall_counter = (state == STATE_FALLING) ? fall_counter + 1 : 0;

        case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                if (!ground) begin
                    next_state = STATE_FALLING;
                    aaah = 1;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                    digging = 1;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            
            STATE_WALK_RIGHT: begin
                walk_right = 1;
                if (!ground) begin
                    next_state = STATE_FALLING;
                    aaah = 1;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                    digging = 1;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALLING: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = STATE_SPLATTER;
                    end else begin
                        next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    end
                end
            end

            STATE_DIGGING: begin
                digging = 1;
                if (!ground) begin
                    next_state = STATE_FALLING;
                    aaah = 1;
                end else if (ground) begin
                    // Stay in digging state as long as ground is present
                    next_state = STATE_DIGGING; 
                end
            end

            STATE_SPLATTER: begin
                // All outputs remain 0 in this state
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule