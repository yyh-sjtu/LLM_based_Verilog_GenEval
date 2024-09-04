
module TopModule (
    input  wire [2:0] vec,  // 3-bit input vector
    output wire [2:0] outv, // 3-bit output vector
    output wire o2,         // Output for bit 2 (vec[2])
    output wire o1,         // Output for bit 1 (vec[1])
    output wire o0          // Output for bit 0 (vec[0])
);

    // Assign the output vector to the input vector
    assign outv = vec;
    
    // Drive the individual outputs from the input vector
    assign o2 = vec[2]; // Output for bit 2
    assign o1 = vec[1]; // Output for bit 1
    assign o0 = vec[0]; // Output for bit 0

endmodule