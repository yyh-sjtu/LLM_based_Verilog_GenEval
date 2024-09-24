
module TopModule(
    input [2:0] y, // current state
    input w,       // input signal
    output Y1      // output
);

// Determine the next state logic for y[1]
assign Y1 = (y == 3'b100) || (y == 3'b101) || // State E or F -> Y1 = 1
            ((y == 3'b001) && w) ||         // State B with w = 1 -> Y1 = 1
            ((y == 3'b010) && (w)) ||       // State C with w = 1 -> Y1 = 1
            ((y == 3'b011) && w);           // State D with w = 1 -> Y1 = 1
// All other cases, Y1 = 0

endmodule