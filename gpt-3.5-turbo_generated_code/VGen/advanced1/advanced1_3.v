
module signed_adder(
    input  [7:0] a,         // First 8-bit signed number
    input  [7:0] b,         // Second 8-bit signed number
    output [7:0] s,         // Sum of a and b
    output overflow         // Overflow flag
);
    wire [8:0] sum;        // 9-bit sum to capture overflow

    // Perform addition with an extra bit to capture overflow
    assign sum = {1'b0, a} + {1'b0, b};

    // Assign the lower 8 bits to the output sum
    assign s = sum[7:0];

    // Determine overflow condition
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule