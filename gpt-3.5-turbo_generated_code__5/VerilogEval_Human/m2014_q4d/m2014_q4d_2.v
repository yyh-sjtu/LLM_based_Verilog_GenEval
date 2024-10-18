
module d_ff (
  input logic clk,
  input logic d,
  output logic q
);

  always_ff @(posedge clk) begin
    q <= d;
  end
endmodule

module xor (
  input logic a,
  input logic b,
  output logic y
);

  assign y = a ^ b;
endmodule

module top_module (
  input logic clk,
  input logic in,
  output logic out
);

  logic xor_out;
  d_ff flip_flop (.clk(clk), .d(xor_out), .q(out));
  xor xor_gate (.a(in), .b(out), .y(xor_out));

endmodule