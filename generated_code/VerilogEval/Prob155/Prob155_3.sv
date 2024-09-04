
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

    // State declaration
    typedef enum logic [2:0] {
        FALLING         = 3'b000,
        WALKING_LEFT    = 3'b001,
        WALKING_RIGHT   = 3'b010,
        DIGGING         = 3'b011,
        SPLATTERED      = 3'b100
    } state_t;

    // State variables
    state_t current_state, next_state;

    // Falling counter
    logic [4:0] fall_counter;  // 5 bits to count up to 31

    // State encoding
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALKING_LEFT; // Reset to walking left
            fall_counter <= 0;              // Reset fall counter
        end else begin
            current_state <= next_state;    // Move to next state
            if (current_state == FALLING) begin
                fall_counter <= fall_counter + 1; // Increment fall counter
            end else begin
                fall_counter <= 0; // Reset counter when not falling
            end
        end
    end

    // Next state logic based on current state and inputs
    always_comb begin
        next_state = current_state; // Default to current state
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            WALKING_LEFT: begin
                walk_left = 1;
                if (~ground) begin
                    next_state = FALLING;
                    aaah = 1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1;
                end else if (bump_right) begin
                    next_state = WALKING_RIGHT;
                end else if (bump_left) begin
                    next_state = WALKING_RIGHT;
                end
            end

            WALKING_RIGHT: begin
                walk_right = 1;
                if (~ground) begin
                    next_state = FALLING;
                    aaah = 1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1;
                end else if (bump_left) begin
                    next_state = WALKING_LEFT;
                end else if (bump_right) begin
                    next_state = WALKING_LEFT;
                end
            end            

            FALLING: begin
                aaah = 1; // Falling state says "aaah"
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = (walk_left) ? WALKING_LEFT : WALKING_RIGHT;
                    end
                end
            end

            DIGGING: begin
                digging = 1;
                if (~ground) begin
                    next_state = FALLING;
                    aaah = 1;
                end else if (ground) begin
                    next_state = (walk_left) ? WALKING_LEFT : WALKING_RIGHT;
                end
            end

            SPLATTERED: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end

            default: begin
                next_state = WALKING_LEFT; // Fallback to a benign state
            end
        endcase
    end

endmodule