
module TopModule(
    input wire [3:0] in,
    output wire [3:0] out_both,
    output wire [3:0] out_any,
    output wire [3:0] out_different
);

// Assigning out_both based on the condition for each bit and its left neighbor
assign out_both[0] = 1'b0;                 // There's no neighbor to the left for in[0]
assign out_both[1] = in[1] & in[0];       // Both in[1] and in[0]
assign out_both[2] = in[2] & in[1];       // Both in[2] and in[1]
assign out_both[3] = in[3] & in[2];       // Both in[3] and in[2]

// Assigning out_any based on the condition for each bit and its right neighbor
assign out_any[0] = 1'b0;                  // There's no neighbor to the right for in[0]
assign out_any[1] = in[1] | in[0];        // Any of in[1] or in[0]
assign out_any[2] = in[2] | in[1];        // Any of in[2] or in[1]
assign out_any[3] = in[3] | in[2];        // Any of in[3] or in[2]

// Assigning out_different based on comparing each bit with its left neighbor with wrapping
assign out_different[0] = (in[0] != in[3]); // Compare in[0] and in[3]
assign out_different[1] = (in[1] != in[0]); // Compare in[1] and in[0]
assign out_different[2] = (in[2] != in[1]); // Compare in[2] and in[1]
assign out_different[3] = (in[3] != in[2]); // Compare in[3] and in[2]

endmodule