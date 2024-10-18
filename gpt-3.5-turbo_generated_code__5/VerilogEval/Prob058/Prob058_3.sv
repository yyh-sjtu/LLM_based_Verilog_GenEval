
module TopModule (
  input  wire clk,
  input  wire a,
  input  wire b,
  output wire out_assign,
  output wire out_always_comb,
  output wire out_always_ff
);
  
  reg out_always_ff_reg;
  
  // XOR gate using assign statement
  assign out_assign = a ^ b;
  
  // XOR gate using combinational always block
  always @* begin
    out_always_comb = a ^ b;
  end
  
  // XOR gate using clocked always block
  always @(posedge clk) begin
    out_always_ff_reg <= a ^ b;
  end
  
  // Output with flip-flop delay
  assign out_always_ff = out_always_ff_reg;
  
endmodule