
module TopModule (
    input  wire p1a,
    input  wire p1b,
    input  wire p1c,
    input  wire p1d,
    input  wire p2a,
    input  wire p2b,
    input  wire p2c,
    input  wire p2d,
    output wire p1y,
    output wire p2y
);

    // First 4-input NAND gate
    assign p1y = ~(p1a & p1b & p1c & p1d);

    // Second 4-input NAND gate
    assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule