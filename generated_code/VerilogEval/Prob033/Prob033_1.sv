
module TopModule (
    input  [7:0] a,     // 8-bit input a
    input  [7:0] b,     // 8-bit input b
    output [7:0] s,     // 8-bit output sum
    output overflow      // Overflow output
);
    
    wire signed [8:0] sum;   // 9-bit wire to capture the sum
    assign sum = {1'b0, a} + {1'b0, b}; // Extend a and b to 9 bits for addition

    assign s = sum[7:0]; // Lower 8 bits represent the sum
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]); // Check for overflow condition

endmodule