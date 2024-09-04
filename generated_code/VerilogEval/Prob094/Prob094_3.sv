
module TopModule (
    input  [3:0] in,              // 4-bit input
    output [3:0] out_both,        // Output: both inputs are 1
    output [3:0] out_any,         // Output: at least one input is 1
    output [3:0] out_different     // Output: inputs are different
);
    
    // Calculate out_both
    assign out_both[0] = 1'b0; // No neighbor on the left for in[0]
    assign out_both[1] = in[1] & in[0]; // Check in[1] and in[0]
    assign out_both[2] = in[2] & in[1]; // Check in[2] and in[1]
    assign out_both[3] = in[3] & in[2]; // Check in[3] and in[2]
    
    // Calculate out_any
    assign out_any[3] = 1'b0; // No neighbor on the right for in[3]
    assign out_any[2] = in[2] | in[3]; // Check in[2] and in[3]
    assign out_any[1] = in[1] | in[2]; // Check in[1] and in[2]
    assign out_any[0] = in[0] | in[1]; // Check in[0] and in[1]

    // Calculate out_different
    assign out_different[0] = in[0] ^ in[3]; // Wrap around (in[0] and in[3])
    assign out_different[1] = in[1] ^ in[0]; // Check in[1] and in[0]
    assign out_different[2] = in[2] ^ in[1]; // Check in[2] and in[1]
    assign out_different[3] = in[3] ^ in[2]; // Check in[3] and in[2]

endmodule