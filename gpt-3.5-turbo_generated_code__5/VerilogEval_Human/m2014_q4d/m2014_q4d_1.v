module xor_gate (
  input a,
  input b,
  output y
);

  assign y = a ^ b;

endmodule

module d_flip_flop (
  input clk,
  input d,
  output q
);

  reg q;

  always @(posedge clk)
    q <= d;

endmodule

module top_module (
  input clk,
  input in,
  output out
);

  wire xor_output;
  wire d_ff_output;

  xor_gate u1 (
    .a(in),
    .b(out),
    .y(xor_output)
  );

  d_flip_flop u2 (
    .clk(clk),
    .d(xor_output),
    .q(d_ff_output)
  );

  assign out = d_ff_output;

endmodule

