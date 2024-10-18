
module TopModule (
  input a,
  input b,
  output out
);

  // Assign the output 'out' to the NOR of inputs 'a' and 'b'
  assign out = ~(a | b);

endmodule