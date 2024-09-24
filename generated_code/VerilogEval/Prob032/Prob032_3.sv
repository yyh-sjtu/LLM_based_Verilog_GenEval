
module TopModule (
    input  [2:0] vec,  // 3-bit input vector
    output [2:0] outv, // 3-bit output
    output o2,         // Output for position 2
    output o1,         // Output for position 1
    output o0          // Output for position 0
);

// Assign the 3-bit output directly from the input vector
assign outv = vec;

// Split the input vector into 1-bit outputs
assign o2 = vec[2]; // Output o2 from position 2 of vec
assign o1 = vec[1]; // Output o1 from position 1 of vec
assign o0 = vec[0]; // Output o0 from position 0 of vec

endmodule