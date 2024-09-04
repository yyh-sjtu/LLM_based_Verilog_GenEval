
module FullAdde(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;    // Sum is the XOR of the three inputs
    assign cout = (a & b) | (cin & (a ^ b)); // Carry-out
endmodule

module TopModule (
    input  [3:0] x,  // 4-bit input x
    input  [3:0] y,  // 4-bit input y
    output [4:0] sum // 5-bit output sum
);

    wire [3:0] carry; // Internal carry signals

    // Instantiate the full adders for each bit
    FullAdde fa0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),
        .sum(sum[0]),
        .cout(carry[0])
    );

    FullAdde fa1 (
        .a(x[1]),
        .b(y[1]),
        .cin(carry[0]),
        .sum(sum[1]),
        .cout(carry[1])
    );

    FullAdde fa2 (
        .a(x[2]),
        .b(y[2]),
        .cin(carry[1]),
        .sum(sum[2]),
        .cout(carry[2])
    );

    FullAdde fa3 (
        .a(x[3]),
        .b(y[3]),
        .cin(carry[2]),
        .sum(sum[3]),
        .cout(sum[4]) // The last carry is the overflow
    );

endmodule