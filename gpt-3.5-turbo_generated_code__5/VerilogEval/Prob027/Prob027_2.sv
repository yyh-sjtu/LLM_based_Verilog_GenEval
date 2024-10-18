
module FullAdder(
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  assign {cout, sum} = a + b + cin;

endmodule

module TopModule(
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  wire cout_intermediate;
  wire sum_intermediate;

  FullAdder full_adder(
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout_intermediate),
    .sum(sum_intermediate)
  );

  // Output assignments
  assign cout = cout_intermediate;
  assign sum = sum_intermediate;

endmodule