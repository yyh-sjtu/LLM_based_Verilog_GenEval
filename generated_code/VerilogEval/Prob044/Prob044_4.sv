
module TopModule (
    input  wire [2:0] a,              // 3-bit input a
    input  wire [2:0] b,              // 3-bit input b
    output wire [2:0] out_or_bitwise, // 3-bit output for bitwise OR
    output wire out_or_logical,       // 1-bit output for logical OR
    output wire [5:0] out_not         // 6-bit output for NOT
);

// Bitwise OR of the two 3-bit inputs
assign out_or_bitwise = a | b;

// Logical OR of the two vectors; a logical OR returns 1 if any bit is 1
assign out_or_logical = |(a | b);

// NOT operation
assign out_not[5:3] = ~b; // Upper half: NOT of b
assign out_not[2:0] = ~a; // Lower half: NOT of a

endmodule