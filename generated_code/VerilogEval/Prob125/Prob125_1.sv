
module TopModule (
    input wire  a,
    input wire  b,
    input wire  c,
    input wire  d, // 'd' is a don't-care input
    output wire out
);

// Logic implementation
assign out = c | a; // out is true if either c is true or a is true

endmodule