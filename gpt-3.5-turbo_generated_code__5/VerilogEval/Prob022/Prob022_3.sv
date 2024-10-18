
module TopModule(
  input a,
  input b,
  input sel,
  output reg out
);
  
  always @(a, b, sel) begin
    if(sel == 1'b0)
      out = a;
    else
      out = b;
  end

endmodule