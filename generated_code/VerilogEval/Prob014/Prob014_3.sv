
module TopModule (
    input wire a,   // 1-bit input a
    input wire b,   // 1-bit input b
    output wire out // 1-bit output out
);

// Implementing the AND operation
assign out = a & b;

endmodule