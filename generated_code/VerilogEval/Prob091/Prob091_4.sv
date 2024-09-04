
module TopModule (
    input  [5:0] y,  // current state
    input        w,   // input signal
    output       Y1,  // output signal for state flip-flop y[1]
    output       Y3   // output signal for state flip-flop y[3]
);

// State logic for Y1 and Y3 based on the current state y and the input w

assign Y1 = (y[1] && w) ||                 // Transition from B to C
            (y[5] && !w);                  // Transition from F to D 

assign Y3 = (y[3] && w) ||                 // Transition from D to C
            (y[2] && !w) ||                // Transition from C to D
            (y[3] && !w);                  // Stay in D on 0

endmodule