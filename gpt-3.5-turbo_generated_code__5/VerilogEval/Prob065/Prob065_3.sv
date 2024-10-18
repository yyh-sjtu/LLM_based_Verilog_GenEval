
module TopModule(
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p1y,
  output p2y
);

  wire internal1;
  wire internal2;
  
  // 4-input NAND gate instantiation
  NAND4 nand1(
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(internal1)
  );
  
  NAND4 nand2(
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(internal2)
  );
  
  // Output assignment
  assign p1y = internal1;
  assign p2y = internal2;
  
endmodule

module NAND4(
  input a,
  input b,
  input c,
  input d,
  output y
);
  
  // Intermediate signals
  wire nand1_out;
  wire nand2_out;
  
  // First stage NAND gates
  NAND2 nand_1a(
    .a(a),
    .b(b),
    .y(nand1_out)
  );
  
  NAND2 nand_1b(
    .a(c),
    .b(d),
    .y(nand2_out)
  );
  
  // Second stage NAND gate
  NAND2 nand_2(
    .a(nand1_out),
    .b(nand2_out),
    .y(y)
  );
  
endmodule

module NAND2(
  input a,
  input b,
  output y
);
  
  // Intermediate signal
  wire and_out;
  
  // AND gate
  and(
    and_out,
    a,
    b
  );
  
  // Inverter
  not(
    y,
    and_out
  );
  
endmodule