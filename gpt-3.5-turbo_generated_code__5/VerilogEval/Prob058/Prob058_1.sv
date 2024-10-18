
module TopModule(
    input clk,
    input a,
    input b,
    output reg out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);
  
  always @(a, b)
    assign out_assign = a ^ b;

  always @*
    out_always_comb = a ^ b;

  always @(posedge clk)
    out_always_ff <= a ^ b;

endmodule