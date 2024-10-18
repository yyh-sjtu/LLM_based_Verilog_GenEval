
module TopModule(
  input a,
  input b,
  input c,
  input d,
  output q
);

  // combinational logic implementation
  assign q = (~a & ~b & ~c & d) |
            (~a & ~b & c & ~d) |
            (~a & b & ~c & ~d) |
            (a & ~b & ~c & ~d) |
            (a & b & ~c & d) |
            (a & b & c & ~d);

endmodule