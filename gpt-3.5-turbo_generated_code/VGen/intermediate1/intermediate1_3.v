
// This is a half adder.
module half_adder(
    input a,      // Input a
    input b,      // Input b
    output cout,  // Carry output
    output sum    // Sum output
);

// Assigning outputs based on the logic of a half adder
assign sum = a ^ b;    // Sum is the XOR of the inputs
assign cout = a & b;   // Carry is the AND of the inputs

endmodule