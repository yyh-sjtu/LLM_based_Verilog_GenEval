
module TopModule(
    input [5:0] y,   // State input (one-hot)
    input w,         // Input signal
    output Y1,       // Output for state flip-flop y[1]
    output Y3        // Output for state flip-flop y[3]
);

    // Assign outputs based on the current state
    assign Y1 = y[1];  // Y1 is 1 when in State B
    assign Y3 = y[3];  // Y3 is 1 when in State D

endmodule