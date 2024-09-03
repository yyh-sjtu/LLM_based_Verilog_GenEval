module for a full adder using half adders
module full_adder (
input a, b, cin,
output sum, cout
);

// Create internal signals for the intermediate W and X signals using half adders
wire w, x;

// Instantiate the half adders for the first stage
half_adder ha1 (
.a(a),
.b(b),
.sum(w),
.cout(x)
);

// Instantiate the half adder for the second stage
half_adder ha2 (
.a(w),
.b(cin),
.sum(sum),
.cout(cout)
);

endmodule

