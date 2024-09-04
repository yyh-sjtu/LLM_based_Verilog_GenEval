
module TopModule (
    input  wire a,     // First input bit
    input  wire b,     // Second input bit
    input  wire cin,   // Carry-in bit
    output wire cout,  // Carry-out bit
    output wire sum    // Sum bit
);

    // Full adder logic
    assign sum = a ^ b ^ cin;        // Sum is the XOR of a, b, and cin
    assign cout = (a & b) | (cin & (a ^ b)); // Carry-out logic

endmodule