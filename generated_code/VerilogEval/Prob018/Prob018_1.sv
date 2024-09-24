
module TopModule (
    input  [255:0] in,  // 256-bit input
    input  [7:0]   sel, // 8-bit select input
    output         out   // 1-bit output
);

    // Assign the output based on the select line
    assign out = in[sel];

endmodule