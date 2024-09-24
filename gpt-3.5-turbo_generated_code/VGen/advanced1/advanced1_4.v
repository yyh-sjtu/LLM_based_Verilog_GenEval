
module signed_adder(
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] s,
    output overflow
);
    // Internal wire for the sum
    wire [8:0] sum; // 9 bits to check for overflow
    assign sum = {1'b0, a} + {1'b0, b}; // Extend a and b to 9 bits for addition

    // Assign sum to output, discard the carry-out
    assign s = sum[7:0];

    // Overflow detection logic
    // Overflow occurs when:
    // 1. Both inputs are positive and the result is negative.
    // 2. Both inputs are negative and the result is positive.
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule