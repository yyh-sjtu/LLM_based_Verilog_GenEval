
module FullAdder(
    input a,          // One bit input
    input b,          // One bit input
    input cin,        // Carry input
    output sum,       // Sum output
    output cout       // Carry output
);
    assign sum = a ^ b ^ cin;    // Sum bit
    assign cout = (a & b) | (cin & (a ^ b)); // Carry out
endmodule

module TopModule(
    input [3:0] x,  // 4-bit input
    input [3:0] y,  // 4-bit input
    output [4:0] sum // 5-bit output
);
    wire [3:0] sum_bits;   // Sum bits
    wire [3:0] carry;      // Carry from each full adder
    wire cout;             // Carry out from the last adder

    // Instantiate four full adders
    FullAdder fa0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0), // No initial carry
        .sum(sum_bits[0]),
        .cout(carry[0])
    );

    FullAdder fa1 (
        .a(x[1]),
        .b(y[1]),
        .cin(carry[0]),
        .sum(sum_bits[1]),
        .cout(carry[1])
    );

    FullAdder fa2 (
        .a(x[2]),
        .b(y[2]),
        .cin(carry[1]),
        .sum(sum_bits[2]),
        .cout(carry[2])
    );

    FullAdder fa3 (
        .a(x[3]),
        .b(y[3]),
        .cin(carry[2]),
        .sum(sum_bits[3]),
        .cout(cout) // Final carry out
    );

    // Connect sum bits and final carry out to the output
    assign sum = {cout, sum_bits}; // Concatenating cout with sum_bits

endmodule