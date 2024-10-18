
module TopModule(
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire q_tmp1, q_tmp2;

  assign q_tmp1 = (~a & ~b & c & ~d) | (~a & b & ~c & d) | (a & ~b & ~c & d);
  assign q_tmp2 = (~a & b & c & ~d) | (a & ~b & c & d) | (a & b & ~c & ~d);
  assign q = ~(q_tmp1 | q_tmp2);

endmodule