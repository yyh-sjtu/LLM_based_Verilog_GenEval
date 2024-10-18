
module TopModule(
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

  wire and1_out;
  wire and2_out;

  // First Layer: AND Gates
  and gate_and1 (and1_out, a, b);
  and gate_and2 (and2_out, c, d);

  // Second Layer: OR Gate and NOT Gate
  or gate_or (out, and1_out, and2_out);
  assign out_n = ~out;

endmodule