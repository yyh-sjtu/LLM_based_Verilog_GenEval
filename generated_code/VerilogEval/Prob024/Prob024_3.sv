
module TopModule (
    input  wire a,      // Input bit a
    input  wire b,      // Input bit b
    output wire sum,    // Output sum
    output wire cout    // Output carry-out
);

// Calculate sum and carry-out for a half adder
assign sum = a ^ b;     // Sum is the XOR of a and b
assign cout = a & b;    // Carry-out is the AND of a and b

endmodule