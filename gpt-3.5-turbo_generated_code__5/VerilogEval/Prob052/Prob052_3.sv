
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  assign out_and = &in;
  assign out_or = |in;
  
  reg out_xor;
  always @* begin
    out_xor = in[0];
    for (int i = 1; i < 100; i = i + 1) begin
      out_xor = out_xor ^ in[i];
    end
  end

endmodule