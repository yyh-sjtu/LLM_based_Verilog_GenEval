module full_adder(
input a, b, cin,
output sum, cout
);

wire out1, out2, out3;

// First stage of addition
half_adder HA1(
.a(a),
.b(b),
.sum(out1),
.cout(out2)
);

// Second stage of addition
half_adder HA2(
.a(out1),
.b(cin),
.sum(sum),
.cout(out3)
);

// Final OR gate to combine the carry output from the second stage and the carry output from the first stage
assign cout = out2 | out3;

endmodule
