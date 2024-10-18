
module TopModule(
  input clk,
  input a,
  input b,
  output reg out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

  // Using assign statement
  assign out_assign = a ^ b;

  // Using combinational always block
  always @*
    out_always_comb = a ^ b;

  // Using clocked always block
  reg xor_out_ff;
  always @(posedge clk)
    xor_out_ff <= a ^ b;

  // Output assignment for clocked always block
  assign out_always_ff = xor_out_ff;

endmodule