module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
);

wire [7:0] carry;
wire [7:0] sum_intermediate;

fulladder fa0 (
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .sum(sum_intermediate[0]),
    .cout(carry[0])
);

fulladder fa1 (
    .a(a[1]),
    .b(b[1]),
    .cin(carry[0]),
    .sum(sum_intermediate[1]),
    .cout(carry[1])
);

fulladder fa2 (
    .a(a[2]),
    .b(b[2]),
    .cin(carry[1]),
    .sum(sum_intermediate[2]),
    .cout(carry[2])
);

fulladder fa3 (
    .a(a[3]),
    .b(b[3]),
    .cin(carry[2]),
    .sum(sum_intermediate[3],
    .cout(carry[3])
);

fulladder fa4 (
    .a(a[4]),
    .b(b[4]),
    .cin(carry[3]),
    .sum(sum_intermediate[4]),
    .cout(carry[4])
);

fulladder fa5 (
    .a(a[5]),
    .b(b[5]),
    .cin(carry[4]),
    .sum(sum_intermediate[5]),
    .cout(carry[5])
);

fulladder fa6 (
    .a(a[6]),
    .b(b[6]),
    .cin(carry[5]),
    .sum(sum_intermediate[6]),
    .cout(carry[6])
);

fulladder fa7 (
    .a(a[7]),
    .b(b[7]),
    .cin(carry[6]),
    .sum(sum_intermediate[7]),
    .cout(cout)
);

assign sum = sum_intermediate;

endmodule

module fulladder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign {cout, sum} = a + b + cin;

endmodule
