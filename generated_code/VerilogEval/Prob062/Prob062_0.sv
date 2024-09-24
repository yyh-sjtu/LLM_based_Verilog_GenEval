
module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out // Changed from single bit to 8 bits
);

    assign out = (~sel) ? a : b; // Use the conditional (ternary) operator for clarity

endmodule