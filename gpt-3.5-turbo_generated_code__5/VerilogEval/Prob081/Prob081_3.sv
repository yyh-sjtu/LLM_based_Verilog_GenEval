
module TopModule(
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  input p1e,
  input p1f,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p1y,
  output p2y
);

  // Intermediate wires for the AND gates
  wire p1_y1, p1_y2;
  wire p2_y1, p2_y2;

  // AND gates
  and #(6) p1_and1(p1_y1, p1a, p1b, p1c);
  and #(6) p1_and2(p1_y2, p1d, p1e, p1f);
  and #(4) p2_and1(p2_y1, p2a, p2b);
  and #(4) p2_and2(p2_y2, p2c, p2d);

  // OR gates
  or #(2) p1_or(p1y, p1_y1, p1_y2);
  or #(2) p2_or(p2y, p2_y1, p2_y2);

endmodule