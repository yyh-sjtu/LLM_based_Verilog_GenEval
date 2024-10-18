
module TopModule (
  input  clk,
  input  in,
  output out
);
  
  wire xor_out;
  
  xor #(1) xor_inst (
    .a(in),
    .b(out),
    .z(xor_out)
  );
  
  always @(posedge clk) begin
    out <= xor_out;
  end
  
endmodule