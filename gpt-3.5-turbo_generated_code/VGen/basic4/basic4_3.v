
module mux (
    input [4:0] a,     // 5-bit input a
    input [4:0] b,     // 5-bit input b
    input sel,         // selector input
    output [4:0] out   // 5-bit output
);

// Multiplexing logic
assign out = (sel == 1'b0) ? a : b;

endmodule