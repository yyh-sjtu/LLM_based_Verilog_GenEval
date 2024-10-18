
module TopModule(
  input a,
  input b,
  output out_assign,
  output out_alwaysblock
);

  assign out_assign = a & b; // Using assign statement for AND gate

  // Using a combinational always block for AND gate
  always @* begin
    out_alwaysblock = a & b;
  end

endmodule