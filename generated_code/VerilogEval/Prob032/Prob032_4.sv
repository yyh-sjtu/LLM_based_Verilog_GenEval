
module TopModule (
    input  wire [2:0] vec,   // 3-bit input vector
    output wire [2:0] outv,  // 3-bit output vector
    output wire o2,          // Output for vec[2]
    output wire o1,          // Output for vec[1]
    output wire o0           // Output for vec[0]
);

    // Assign the 3-bit output directly from the input vector
    assign outv = vec;

    // Split the 3-bit input vector into individual 1-bit outputs
    assign o0 = vec[0]; // LSB
    assign o1 = vec[1];
    assign o2 = vec[2]; // MSB

endmodule