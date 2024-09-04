
module TopModule (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define state enum
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT
} state_t;

// Define state register
reg [1:0] state_reg, next_state_reg;

// Implement Moore state machine
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state_reg <= WALK_LEFT;
    end else begin
        state_reg <= next_state_reg;
    end
end

always @(*) begin
    next_state_reg = state_reg;
    walk_left = (state_reg == WALK_LEFT);
    walk_right = (state_reg == WALK_RIGHT);
    
    // State transitions based on input bump signals
    case (state_reg)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state_reg = WALK_RIGHT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state_reg = WALK_LEFT;
            end
        end
    endcase
end

endmodule