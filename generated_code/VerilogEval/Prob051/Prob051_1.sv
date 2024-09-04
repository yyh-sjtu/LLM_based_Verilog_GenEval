
module TopModule (
    input  [3:0] in,      // 4-bit input
    output       out_and, // Output of the 4-input AND gate
    output       out_or,  // Output of the 4-input OR gate
    output       out_xor  // Output of the 4-input XOR gate
);

    // Implementing the 4-input AND gate
    assign out_and = in[0] & in[1] & in[2] & in[3];

    // Implementing the 4-input OR gate
    assign out_or = in[0] | in[1] | in[2] | in[3];

    // Implementing the 4-input XOR gate
    assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule