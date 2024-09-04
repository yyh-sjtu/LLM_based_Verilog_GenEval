
module TopModule (
    input  [255:0] in,  // 256-bit input vector
    input  [7:0]   sel, // 8-bit select input
    output         out   // 1-bit output
);

// Assign the output to the selected input bit
assign out = in[sel];

endmodule