
module TopModule(
  input  a,
  input  b,
  input  c,
  input  d,
  output out
);

  // Intermediate signals for Karnaugh map
  wire ab_00, ab_01, ab_11, ab_10;

  // Implementing Karnaugh map
  assign ab_00 = ~(a & b & ~c & d);
  assign ab_01 = ~(a & ~b & ~c & ~d);
  assign ab_11 = ~(a & ~b & c & ~d);
  assign ab_10 = ~(~a & ~b & c & ~d);

  // Final output
  assign out = ~ab_00 & ~ab_01 & ~ab_10 & ~ab_11;

endmodule