
module TopModule (
    input  [99:0] a,     // 100-bit input a
    input  [99:0] b,     // 100-bit input b
    input         sel,    // 1-bit select input
    output [99:0] out     // 100-bit output
);

    // Multiplexer Logic
    assign out = (sel == 1'b0) ? a : b;

endmodule