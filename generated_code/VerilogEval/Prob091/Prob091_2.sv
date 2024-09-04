
module TopModule (
    input  [5:0] y,
    input        w,
    output       Y1,
    output       Y3
);

// Condition for Y1 to be high (active) when in states B (y[1]) or C (y[2])
assign Y1 = y[1] | y[2]; // B or C

// Condition for Y3 to be high (active) when in states D (y[3]) or F (y[5])
assign Y3 = y[3] | y[5]; // D or F

// Next state logic for one-hot encoding
always @(*) begin
    case (y)
        6'b000001: begin // State A
            next_state = (w) ? 6'b000010 : 6'b000001; // B or A
        end
        6'b000010: begin // State B
            next_state = (w) ? 6'b000100 : 6'b001000; // C or D
        end
        6'b000100: begin // State C
            next_state = (w) ? 6'b010000 : 6'b001000; // E or D
        end
        6'b001000: begin // State D
            next_state = (w) ? 6'b100000 : 6'b000001; // F or A
        end
        6'b010000: begin // State E
            next_state = (w) ? 6'b010000 : 6'b001000; // E or D
        end
        6'b100000: begin // State F
            next_state = (w) ? 6'b000100 : 6'b001000; // C or D
        end
        default: next_state = 6'b000001; // Reset to state A
    endcase
end

endmodule