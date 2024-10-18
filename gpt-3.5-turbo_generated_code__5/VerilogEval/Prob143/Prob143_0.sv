
module TopModule(
  input wire in,
  input wire [9:0] state,
  output wire [9:0] next_state,
  output wire out1,
  output wire out2
);

  // State Transition Logic
  assign next_state[0] = (~state[9] & ~state[8] & ~state[7]) | (state[9] & state[1]) | (state[5] & state[0]);
  assign next_state[1] = (state[0] & ~state[9]) | (state[1] & state[5]) | (state[9] & state[8]);
  assign next_state[2] = state[1] & ~state[5];
  assign next_state[3] = state[2] & ~state[1];
  assign next_state[4] = state[3] & ~state[2];
  assign next_state[5] = state[4] & ~state[3];
  assign next_state[6] = state[5] & ~state[4];
  assign next_state[7] = state[6] | (state[7] & ~state[0] & ~state[1]);
  assign next_state[8] = state[7] & ~state[6];
  assign next_state[9] = state[8] & ~state[7];

  // Output Logic
  assign out1 = (state[0] & ~state[1]) | (state[5] & ~state[0]) | (state[6] & ~state[2]) | (state[7] & ~state[3]);
  assign out2 = state[7] & state[0];
  
endmodule