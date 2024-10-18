
module TopModule (
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

// State transition logic
assign next_state[0] = ((state[0] & !in) | (!state[0] & state[1] & in));
assign next_state[1] = ((state[1] & !in) | (state[0] & !state[1] & !in));
assign next_state[2] = ((state[2] & !in) | (!state[2] & state[3] & in));
assign next_state[3] = ((state[3] & !in) | (state[2] & !state[3] & !in));

// Output logic
assign out = state[3];

endmodule