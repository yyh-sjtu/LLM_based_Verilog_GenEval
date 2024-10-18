module TopModule(
  input clk,
  input d,
  output reg q
);

  reg q1;
  reg q2;

  // Flip-flop 1 triggered on the positive edge of the clock
  always @(posedge clk)
    q1 <= d;

  // Flip-flop 2 triggered on the negative edge of the clock
  always @(negedge clk)
    q2 <= q1;

  // Combine the outputs of both flip-flops to generate the desired behavior
  always @(*)
    q <= q1 | q2;

endmodule

