
module TopModule(
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

// State definitions
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter DIGGING = 2'b11;

// State register
reg [1:0] state, next_state;

// Default values for outputs
assign aaah = 0;
assign digging = 0;

// State machine logic
always @ (posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;  // Reset to initial state of walking left
    end else begin
        state <= next_state;
    end
end

// State transition and output logic
always @* begin
    walk_left = (state == WALK_LEFT);
    walk_right = (state == WALK_RIGHT);

    case(state)
        WALK_LEFT:
            begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
        WALK_RIGHT:
            begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
        FALLING:
            begin
                if (ground) begin
                    next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = FALLING;
                end
                aaah = 1;
            end
        DIGGING:
            begin
                if (!ground) begin
                    next_state = FALLING;
                end else begin
                    next_state = DIGGING;
                end
                digging = 1;
            end
    endcase
end

endmodule