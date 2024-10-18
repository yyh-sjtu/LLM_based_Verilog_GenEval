module nor_gate (
  input logic in1,
  input logic in2,
  output logic out
);
  assign out = ~(in1 | in2);
endmodule

module top_module (
  input in1,
  input in2,
  output logic out
);
  nor_gate nor_gate_inst (
    .in1(in1),
    .in2(in2),
    .out(out)
  );
endmodule

