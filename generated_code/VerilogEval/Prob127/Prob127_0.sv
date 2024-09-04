
module TopModule (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

// Define states for the finite state machine
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

// Define state register and next state logic
reg [1:0] state, next_state;

always @ (posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

// State transition logic
always @ (*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
    endcase
end

// Output logic
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);

endmodule