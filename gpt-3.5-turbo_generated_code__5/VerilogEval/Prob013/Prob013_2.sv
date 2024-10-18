
module TopModule(
  input  wire in1,
  input  wire in2,
  output wire out
);
  // 2-input NOR gate implementation
  assign out = ~(in1 | in2);
endmodule