
module TopModule (
    input  [3:0] x, // 4-bit input
    output f       // 1-bit output
);

// Internal signal for output f
wire f;

// Implement the logical expression derived from K-map
assign f = (x[3] & x[4]) | (x[1] & x[2]);

endmodule