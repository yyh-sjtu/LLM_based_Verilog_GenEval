
module TopModule (
    input  [3:0] in,              // 4-bit input
    output [3:0] out_both,        // 4-bit output for both '1'
    output [3:0] out_any,         // 4-bit output for any '1'
    output [3:0] out_different     // 4-bit output for different
);

    // Compute out_both
    assign out_both[0] = 1'b0;                   // First bit has no left neighbour
    assign out_both[1] = in[1] & in[0];           // Check in[1] and its left neighbour in[0]
    assign out_both[2] = in[2] & in[1];           // Check in[2] and its left neighbour in[1]
    assign out_both[3] = in[3] & in[2];           // Check in[3] and its left neighbour in[2]

    // Compute out_any
    assign out_any[3] = 1'b0;                     // Last bit has no right neighbour
    assign out_any[2] = in[2] | in[3];            // Check in[2] and its right neighbour in[3]
    assign out_any[1] = in[1] | in[2];            // Check in[1] and its right neighbour in[2]
    assign out_any[0] = in[0] | in[1];            // Check in[0] and its right neighbour in[1]

    // Compute out_different
    assign out_different[0] = in[0] ^ in[3];      // Compare in[0] and left neighbour in[3]
    assign out_different[1] = in[1] ^ in[0];      // Compare in[1] and its left neighbour in[0]
    assign out_different[2] = in[2] ^ in[1];      // Compare in[2] and its left neighbour in[1]
    assign out_different[3] = in[3] ^ in[2];      // Compare in[3] and its left neighbour in[2]

endmodule