
module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output out_always
);

  // Assign implementation
  assign out_assign = (sel_b1 & sel_b2) ? b : a;

  // Procedural always implementation
  reg out_reg;  
  always @* begin
    if (sel_b1 & sel_b2) begin
      out_reg = b;
    end
    else begin
      out_reg = a;
    end
  end
  assign out_always = out_reg;

endmodule