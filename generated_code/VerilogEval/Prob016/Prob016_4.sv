
module FullAdder (
    input a,           // First input bit
    input b,           // Second input bit
    input cin,         // Carry in
    output sum,        // Sum output
    output cout        // Carry out
);
    assign sum = a ^ b ^ cin;    // Sum is XOR of inputs and carry in
    assign cout = (a & b) | (cin & (a ^ b));  // Carry out
endmodule

module FourBitAdder (
    input [3:0] x,   // 4-bit input x
    input [3:0] y,   // 4-bit input y
    output [4:0] sum // 5-bit output sum
);
    wire [3:0] carry; // Carry bits for connecting full adders
    wire [3:0] temp_sum; // Intermediate sum

    // Full Adder for the least significant bit
    FullAdder FA0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0), // No initial carry
        .sum(temp_sum[0]),
        .cout(carry[0])
    );

    // Full Adder for the second bit
    FullAdder FA1 (
        .a(x[1]),
        .b(y[1]),
        .cin(carry[0]),
        .sum(temp_sum[1]),
        .cout(carry[1])
    );

    // Full Adder for the third bit
    FullAdder FA2 (
        .a(x[2]),
        .b(y[2]),
        .cin(carry[1]),
        .sum(temp_sum[2]),
        .cout(carry[2])
    );

    // Full Adder for the most significant bit
    FullAdder FA3 (
        .a(x[3]),
        .b(y[3]),
        .cin(carry[2]),
        .sum(temp_sum[3]),
        .cout(carry[3])
    );

    // Assigning the final output sum which includes the overflow bit
    assign sum = {carry[3], temp_sum}; // {overflow, sum}
endmodule

module TopModule (
    input  [3:0] x,   // 4-bit input x
    input  [3:0] y,   // 4-bit input y
    output [4:0] sum  // 5-bit output sum
);
    // Instantiate the FourBitAdder
    FourBitAdder adder (
        .x(x),
        .y(y),
        .sum(sum)
    );
endmodule