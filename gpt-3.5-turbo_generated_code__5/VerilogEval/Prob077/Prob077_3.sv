
module TopModule(
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

  wire and1_output;
  wire and2_output;

  and gate_and1 (and1_output, a, b);
  and gate_and2 (and2_output, c, d);

  or gate_or (out, and1_output, and2_output);
  not gate_not (out_n, out);

endmodule