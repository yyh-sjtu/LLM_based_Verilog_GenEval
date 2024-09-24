
module TopModule (
    input  [2:0] y,    // Current state (3 bits)
    input  w,          // Input signal
    output Y1          // Output signal (second bit of the state)
);

    // Assign output Y1 to the second bit of the state
    assign Y1 = y[1];

    // Next state logic
    // Using a combinational always block to define the next state logic
    reg [2:0] next_state;

    always @(*) begin
        case (y)
            3'b000: // State A
                if (w == 0)
                    next_state = 3'b001; // Transition to B
                else
                    next_state = 3'b000; // Remain in A
            
            3'b001: // State B
                if (w == 0)
                    next_state = 3'b010; // Transition to C
                else
                    next_state = 3'b011; // Transition to D
            
            3'b010: // State C
                if (w == 0)
                    next_state = 3'b100; // Transition to E
                else
                    next_state = 3'b011; // Transition to D
            
            3'b011: // State D
                if (w == 0)
                    next_state = 3'b101; // Transition to F
                else
                    next_state = 3'b000; // Transition to A
            
            3'b100: // State E
                if (w == 0)
                    next_state = 3'b100; // Remain in E
                else
                    next_state = 3'b011; // Transition to D
            
            3'b101: // State F
                if (w == 0)
                    next_state = 3'b010; // Transition to C
                else
                    next_state = 3'b011; // Transition to D
            
            default: next_state = 3'b000; // Default to state A
        endcase
    end

    // Output the next state and current state for testing (if needed)
    // Always block for state update would be used in conjunction with a clock and reset signals

endmodule