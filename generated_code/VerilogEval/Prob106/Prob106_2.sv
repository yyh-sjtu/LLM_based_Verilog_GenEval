
module TopModule (
    input wire [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

// Procedure to interpret scancode
always @(*) begin
    // Default Outputs
    left = 0;
    down = 0;
    right = 0;
    up = 0;

    // Check for each scancode
    case (scancode)
        16'hE06B: left = 1;   // Left arrow
        16'hE072: down = 1;   // Down arrow
        16'hE074: right = 1;  // Right arrow
        16'hE075: up = 1;     // Up arrow
        default: ;             // No output for anything else
    endcase
end

endmodule