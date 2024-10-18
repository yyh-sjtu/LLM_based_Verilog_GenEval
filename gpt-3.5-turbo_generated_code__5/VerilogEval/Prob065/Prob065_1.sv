
module TopModule (
  input p1a, p1b, p1c, p1d,
  input p2a, p2b, p2c, p2d,
  output p1y, p2y
);

  wire n1a, n1b, n1c, n1d; // Intermediate wires for input negations
  wire n2a, n2b, n2c, n2d;

  wire nand1, nand2; // Output wires of NAND gates

  // Logic for negating inputs
  assign n1a = ~p1a;
  assign n1b = ~p1b;
  assign n1c = ~p1c;
  assign n1d = ~p1d;

  assign n2a = ~p2a;
  assign n2b = ~p2b;
  assign n2c = ~p2c;
  assign n2d = ~p2d;

  // NAND1 gate
  assign nand1 = ~(n1a & n1b & n1c & n1d);

  // NAND2 gate
  assign nand2 = ~(n2a & n2b & n2c & n2d);

  // Output assignments
  assign p1y = nand1;
  assign p2y = nand2;

endmodule