
module TopModule(
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

  wire and1_out, and2_out;

  // First layer: AND gates
  and and1(a, b, and1_out);
  and and2(c, d, and2_out);

  // Second layer: OR gate
  or or_gate(and1_out, and2_out, out);
 
  // Inverted output
  not not_gate(out, out_n);

endmodule