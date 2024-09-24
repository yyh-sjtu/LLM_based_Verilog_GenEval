
module TopModule (
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);
    // Next state logic
    assign B3_next = state[8] & 1; // B3 stays in B3
    assign S_next = state[0] & ~d | state[1] & d; // S transition
    assign S1_next = state[1] & ~d | state[2] & d; // S1 transition
    assign Count_next = state[9] & 1 & ~done_counting | 1 & done_counting; // Count transition
    assign Wait_next = state[9] & 1 & ~ack | state[0] & 1 & ack; // Wait transition

    // Output logic
    assign done = state[9]; // done is high when in Wait state
    assign counting = state[9]; // counting is high when in Count state
    assign shift_ena = state[4] | state[5] | state[6] | state[7]; // shift enable when in B0 to B3 states

endmodule