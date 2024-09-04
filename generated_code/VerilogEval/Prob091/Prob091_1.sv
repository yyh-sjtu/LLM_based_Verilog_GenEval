
module TopModule (
    input [5:0] y, // Current state in one-hot encoding
    input w,       // Input signal
    output Y1,     // Output signal for state flip-flop y[1]
    output Y3      // Output signal for state flip-flop y[3]
);

    // Output logic for Y1
    assign Y1 = (y[0] & w) | (y[1]); // Y1 is asserted if the FSM is in state A or B when w is 1

    // Output logic for Y3
    assign Y3 = (y[3]) || (y[0] & w) || (y[2] & ~w); // Y3 is asserted if the FSM is in state D or can transition to D

endmodule