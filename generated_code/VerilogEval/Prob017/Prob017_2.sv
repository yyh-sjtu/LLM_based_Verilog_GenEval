
module TopModule(
    input  [99:0] a,   // 100-bit input
    input  [99:0] b,   // 100-bit input
    input          sel, // 1-bit select input
    output [99:0] out  // 100-bit output
);
    // Multiplexer logic
    assign out = (sel) ? b : a; // If sel is 1 choose b, else choose a

endmodule