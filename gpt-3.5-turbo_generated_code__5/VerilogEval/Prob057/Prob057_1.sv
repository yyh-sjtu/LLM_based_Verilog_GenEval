
module TopModule (
  input  a,
  input  b,
  input  c,
  input  d,
  output out
);

  // Intermediate wire declarations
  wire w1, w2, w3;

  // Assigning intermediate wires
  assign w1 = a & b;
  assign w2 = c & d;
  assign w3 = w1 | w2;

  // Assigning output
  assign out = ~w3;

endmodule