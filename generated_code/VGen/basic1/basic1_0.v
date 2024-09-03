module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module
full_adder fa(
    .a(in[0]),
    .b(in[1]),
    .cin(in[2]),
    .sum(out[0]),
    .cout(out[1])
);

endmodule
