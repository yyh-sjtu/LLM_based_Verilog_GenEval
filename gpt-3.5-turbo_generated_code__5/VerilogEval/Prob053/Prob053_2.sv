
module TopModule (
  input  clk,
  input  in,
  output out
);

  reg out_reg;
  wire xor_out;

  // XOR gate
  assign xor_out = in ^ out_reg;
  
  // D flip-flop
  always @(posedge clk) begin
    out_reg <= xor_out;
  end
  
  assign out = out_reg;

endmodule