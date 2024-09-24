
module TopModule (
    input  [2:0] a,                // 3-bit input a
    input  [2:0] b,                // 3-bit input b
    output [2:0] out_or_bitwise,    // 3-bit output for bitwise OR
    output       out_or_logical,     // 1-bit output for logical OR
    output [5:0] out_not            // 6-bit output for NOT (upper half for b, lower half for a)
);

    // Bitwise OR of inputs a and b
    assign out_or_bitwise = a | b;

    // Logical OR of inputs a and b
    assign out_or_logical = |(a) | |(b);  // Logical OR by checking if any bit is high

    // NOT operation on both inputs
    assign out_not = {~b, ~a};  // Concatenate NOT of b (upper half) and NOT of a (lower half)

endmodule