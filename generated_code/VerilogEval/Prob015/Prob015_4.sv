
module TopModule (
    input  wire [15:0] in,    // 16-bit input
    output wire [7:0]  out_hi, // 8-bit high byte output
    output wire [7:0]  out_lo   // 8-bit low byte output
);

    // Assign the high and low bytes from the 16-bit input
    assign out_hi = in[15:8]; // Extracting the upper 8 bits (high byte)
    assign out_lo = in[7:0];  // Extracting the lower 8 bits (low byte)

endmodule