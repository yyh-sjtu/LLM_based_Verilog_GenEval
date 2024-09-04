
module TopModule (
    input  [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Initialize outputs to 0
    left = 0;
    down = 0;
    right = 0;
    up = 0;
    
    case (scancode)
        16'hE06B: left  = 1;  // Left Arrow
        16'hE072: down  = 1;  // Down Arrow
        16'hE074: right = 1;  // Right Arrow
        16'hE075: up    = 1;  // Up Arrow
        default: ;           // Do nothing for other codes
    endcase
end

endmodule