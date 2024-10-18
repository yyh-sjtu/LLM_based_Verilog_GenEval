
module TopModule(
  input in1,
  input in2,
  output out
);

  wire andInput2;
  
  // Inverter to create the bubble on in2
  not inv1(
    .a(in2),
    .o(andInput2)
  );
  
  // AND gate implementation
  and gate1(
    .a(in1),
    .b(andInput2),
    .z(out)
  );

endmodule