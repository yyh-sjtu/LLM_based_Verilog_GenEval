
module TopModule (
  input in1,
  input in2,
  output out
);
  wire in2_bubble;
  wire and_gate_output;

  assign in2_bubble = ~in2;
  assign and_gate_output = in1 & in2_bubble;
  assign out = and_gate_output;

endmodule