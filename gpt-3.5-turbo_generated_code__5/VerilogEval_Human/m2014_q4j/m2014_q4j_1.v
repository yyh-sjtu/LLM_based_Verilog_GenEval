module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] s;
    wire c1, c2, c3;

    full_adder fa1(
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),
        .sum(s[0]),
        .cout(c1)
    );

    full_adder fa2(
        .a(x[1]),
        .b(y[1]),
        .cin(c1),
        .sum(s[1]),
        .cout(c2)
    );

    full_adder fa3(
        .a(x[2]),
        .b(y[2]),
        .cin(c2),
        .sum(s[2]),
        .cout(c3)
    );

    full_adder fa4(
        .a(x[3]),
        .b(y[3]),
        .cin(c3),
        .sum(s[3]),
        .cout(sum[4])
    );

    assign sum[3:0] = s;
    assign sum[4] = c4;

endmodule

