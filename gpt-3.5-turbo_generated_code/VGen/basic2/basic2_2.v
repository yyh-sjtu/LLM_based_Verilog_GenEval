module
module and_gate (
  input a,
  input b,
  output out
);

  // logic implementation of the AND gate
  assign out = a & b;

endmodule

module test_and_gate;
  reg a, b;
  wire out;

  and_gate and_gate_inst (
    .a(a),
    .b(b),
    .out(out)
  );

  initial begin
    a = 1'b0;
    b = 1'b0;
    $display("a = %b, b = %b, a AND b = %b", a, b, out);

    a = 1'b1;
    b = 1'b0;
    $display("a = %b, b = %b, a AND b = %b", a, b, out);

    a = 1'b0;
    b = 1'b1;
    $display("a = %b, b = %b, a AND b = %b", a, b, out);

    a = 1'b1;
    b = 1'b1;
    $display("a = %b, b = %b, a AND b = %b", a, b, out);
  end
endmodule

