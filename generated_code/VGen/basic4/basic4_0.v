module full_adder(
  input wire a,
  input wire b,
  input wire cin,
  output wire sum,
  output wire cout
);

  wire w1, w2, w3;

  xor gate1 (w1, a, b);
  xor gate2 (sum, w1, cin);

  and gate3 (w2, w1, cin);
  and gate4 (w3, a, b);

  or gate5 (cout, w2, w3);

endmodule

