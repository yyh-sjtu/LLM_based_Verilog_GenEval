
module TopModule (
    input  wire in,
    input  wire [3:0] state,
    output wire [3:0] next_state,
    output wire out
);

    // Next state logic
    assign next_state[0] = (state[3] & ~in) | (state[2] & in) | (state[1] & ~in); // Next state A
    assign next_state[1] = (state[0] & in) | (state[3] & in);                    // Next state B
    assign next_state[2] = (state[1] & ~in) | (state[0] & in);                   // Next state C
    assign next_state[3] = (state[2] & in) | (state[0] & ~in);                   // Next state D

    // Output logic
    assign out = state[3]; // Output is high if in state D

endmodule