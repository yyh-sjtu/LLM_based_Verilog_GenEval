
module TopModule (
    input  [2:0] y,  // 3-bit state
    input  w,        // input bit
    output Y1        // output bit
);

// Next-state logic for y[1] (the second bit of the state)
reg next_y1;

always @(*) begin
    case (y)
        3'b000: next_y1 = 1'b0;  // State A
        3'b001: next_y1 = w ? 1'b1 : 1'b0; // State B
        3'b010: next_y1 = w ? 1'b1 : 1'b0; // State C
        3'b011: next_y1 = w ? 1'b1 : 1'b0; // State D
        3'b100: next_y1 = w ? 1'b1 : 1'b0; // State E
        3'b101: next_y1 = w ? 1'b1 : 1'b0; // State F
        default: next_y1 = 1'b0;  // Default case
    endcase
end

assign Y1 = next_y1; // Connect the next_y1 to output Y1

endmodule