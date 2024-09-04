
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

    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALLING = 2'b10;
    parameter DIGGING = 2'b11;

    reg [1:0] state;
    reg [4:0] fall_counter;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'b00000;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case (state)
                WALK_LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALLING;
                    end else if (dig) begin
                        state <= DIGGING;
                    end
                end
                WALK_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALLING;
                    end else if (dig) begin
                        state <= DIGGING;
                    end
                end
                FALLING: begin
                    fall_counter <= fall_counter + 1;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                    if (ground) begin
                        state <= (fall_counter > 5'b10000) ? WALK_LEFT : WALK_RIGHT;
                    end
                end
                DIGGING: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1;
                    if (!ground) begin
                        state <= FALLING;
                    end
                end
            endcase
        end
    end

endmodule