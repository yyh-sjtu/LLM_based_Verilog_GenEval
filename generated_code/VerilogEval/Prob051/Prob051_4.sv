
module TopModule (
    input   [3:0] in,      // 4-bit input
    output          out_and, // 4-input AND output
    output          out_or,  // 4-input OR output
    output          out_xor   // 4-input XOR output
);

    // 4-input AND operation
    assign out_and = in[0] & in[1] & in[2] & in[3];

    // 4-input OR operation
    assign out_or = in[0] | in[1] | in[2] | in[3];

    // 4-input XOR operation
    assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule