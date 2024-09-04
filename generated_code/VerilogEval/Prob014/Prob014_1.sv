
module TopModule (
    input wire a,   // 1-bit input
    input wire b,   // 1-bit input
    output wire out // 1-bit output
);

// Implement the 2-input AND gate
assign out = a & b;

endmodule