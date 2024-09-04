
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

// Define states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter DIGGING = 2'b11;

// Define internal signals
reg [1:0] state;
reg [4:0] fall_counter;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_counter <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case(state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (!ground) begin
                    state <= FALLING;
                    fall_counter <= 0;
                end else if (dig) begin
                    state <= DIGGING;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (!ground) begin
                    state <= FALLING;
                    fall_counter <= 0;
                end else if (dig) begin
                    state <= DIGGING;
                end
            end
            FALLING: begin
                fall_counter <= fall_counter + 1;
                if (ground) begin
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                    fall_counter <= 0;
                end else if (fall_counter >= 20) begin
                    state <= WALK_LEFT; // Splatter
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            end
            DIGGING: begin
                if (!ground) begin
                    state <= FALLING;
                    fall_counter <= 0;
                end else if (!dig) begin
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end
            end
        endcase
    end
end

always @(*) begin
    case(state)
        WALK_LEFT: begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        WALK_RIGHT: begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
        end
        FALLING: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
        end
        DIGGING: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
        end
    endcase
end

endmodule