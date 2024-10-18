module lemming_fsm (
    input         clk,
    input         reset,
    input         bump_left,
    input         bump_right,
    input         ground,
    input         dig,
    output reg    walk_left,
    output reg    walk_right,
    output reg    aaah,
    output reg    digging
);

    reg [4:0]     state;
    reg [4:0]     next_state;
    reg           fall;
    reg           splatter;

    parameter     WALK_LEFT = 1'b0;
    parameter     WALK_RIGHT = 1'b1;
    parameter     AAAH = 1'b1;
    parameter     DIGGING = 1'b1;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            fall <= 0;
            splatter <= 0;
        end else begin
            state <= next_state;
            fall <= (fall && ~ground) || (fall && state != 5'b10011 && state != 5'b00100) || (~ground && state != 5'b10011);
            splatter <= fall && state == 5'b10011 && ground;
        end
    end

    always @(state or bump_left or bump_right or ground or dig) begin
        case (state)
            5'b00000: begin // Walking Left
                walk_left <= WALK_LEFT;
                walk_right <= WALK_RIGHT;
                aaah <= ~ground || splatter;
                digging <= 0;
                next_state <= bump_left ? 5'b00001 : (bump_right ? 5'b00010 : (fall ? 5'b00011 : (dig ? 5'b00100 : 5'b00000)));
            end
            5'b00001: begin // Walking Right after bumped on left
                walk_left <= WALK_RIGHT;
                walk_right <= WALK_RIGHT;
                aaah <= ~ground || splatter;
                digging <= 0;
                next_state <= bump_right ? 5'b00010 : (fall ? 5'b00011 : (dig ? 5'b00100 : 5'b00001));
            end
            5'b00010: begin // Walking Left after bumped on right
                walk_left <= WALK_LEFT;
                walk_right <= WALK_LEFT;
                aaah <= ~ground || splatter;
                digging <= 0;
                next_state <= bump_left ? 5'b00001 : (fall ? 5'b00011 : (dig ? 5'b00100 : 5'b00010));
            end
            5'b00011: begin // Falling
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= ~ground || splatter;
                digging <= digging;
                next_state <= fall ? 5'b00011 : (ground ? 5'b00000 : 5'b00101);
            end
            5'b00100: begin // Digging
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= ~ground || splatter;
                digging <= (ground && ~fall) ? DIGGING : 0;
                next_state <= ground ? 5'b00101 : 5'b00100;
            end
            5'b00101: begin // Walking after digging
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= ~ground || splatter;
                digging <= 0;
                next_state <= (bump_left || bump_right) ? 5'b00011 : (fall ? 5'b00011 : 5'b00101);
            end
            default: begin
                walk_left <= WALK_LEFT;
                walk_right <= WALK_RIGHT;
                aaah <= ~ground || splatter;
                digging <= 0;
                next_state <= 5'b00000;
            end
        endcase
    end

endmodule

module top_module (
    input         clk,
    input         areset,
    input         bump_left,
    input         bump_right,
    input         ground,
    input         dig,
    output        walk_left,
    output        walk_right,
    output        aaah,
    output        digging
);

    reg [4:0]     state;
    reg [4:0]     next_state;
    reg           fall;
    reg           splatter;

    lemming_fsm uut (
        .clk(clk),
        .reset(areset),
        .bump_left(bump_left),
        .bump_right(bump_right),
        .ground(ground),
        .dig(dig),
        .walk_left(walk_left),
        .walk_right(walk_right),
        .aaah(aaah),
        .digging(digging)
    );

endmodule

