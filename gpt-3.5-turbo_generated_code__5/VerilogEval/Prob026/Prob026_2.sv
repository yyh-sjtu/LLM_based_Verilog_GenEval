
module TopModule (
  input a,
  input b,
  output out_assign,
  output out_alwaysblock
);

  // Implementing the AND gate using an assign statement
  assign out_assign = a & b;
  
  // Implementing the AND gate using a combinational always block
  always @* begin
    out_alwaysblock = a & b;
  end
  
endmodule