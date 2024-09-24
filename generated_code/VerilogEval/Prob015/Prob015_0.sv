
module TopModule (
    input  [15:0] in,      // 16-bit input
    output [7:0] out_hi,   // upper 8 bits
    output [7:0] out_lo    // lower 8 bits
);

// Assign upper byte (bits [15:8]) to out_hi
assign out_hi = in[15:8];

// Assign lower byte (bits [7:0]) to out_lo
assign out_lo = in[7:0];

endmodule