
module TopModule (
    input  [2:0] a,              // 3-bit input a
    input  [2:0] b,              // 3-bit input b
    output [2:0] out_or_bitwise, // 3-bit output for bitwise OR
    output       out_or_logical,  // 1-bit output for logical OR
    output [5:0] out_not         // 6-bit output for NOT of both inputs
);

    // Bitwise OR of a and b
    assign out_or_bitwise = a | b;

    // Logical OR of a and b
    assign out_or_logical = |(a) | |(b);  // Logical OR: true if any bit in a or b is high

    // NOT of a and b, with b in upper half and a in lower half
    assign out_not = {~b, ~a};

endmodule