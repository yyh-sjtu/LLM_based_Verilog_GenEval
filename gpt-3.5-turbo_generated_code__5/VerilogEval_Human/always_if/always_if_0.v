module mux_2to1_assign (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out
);

  assign out = (sel_b1 & sel_b2) ? b : a;

endmodule

module mux_2to1_procedural (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output reg out
);

  always @(*) begin
    if (sel_b1 & sel_b2)
      out = b;
    else
      out = a;
  end

endmodule

module top_module (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);

  mux_2to1_assign mux_assign (
    .a(a),
    .b(b),
    .sel_b1(sel_b1),
    .sel_b2(sel_b2),
    .out(out_assign)
  );

  mux_2to1_procedural mux_procedural (
    .a(a),
    .b(b),
    .sel_b1(sel_b1),
    .sel_b2(sel_b2),
    .out(out_always)
  );

endmodule

