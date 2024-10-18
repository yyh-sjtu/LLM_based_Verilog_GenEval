module A(input x, input y, output z);
  assign z = (x ^ y) & x;
endmodule

module B(input x, input y, output z);
  reg z;

  always@(x, y)
  begin
    case({x, y})
      {1'b0, 1'b0} : z <= 1'b1;
      {1'b1, 1'b0} : z <= 1'b0;
      {1'b0, 1'b1} : z <= 1'b0;
      {1'b1, 1'b1} : z <= 1'b1;
    endcase
  end

endmodule

module TopModule(input x, input y, output z);
  wire aa, ab, ba, bb;
  wire o, a;

  A a1(.x(x), .y(y), .z(aa));
  B b1(.x(x), .y(y), .z(ab));

  A a2(.x(x), .y(y), .z(ba));
  B b2(.x(x), .y(y), .z(bb));

  or gate_or(.a(aa), .b(ab), .o(o));
  and gate_and(.a(ba), .b(bb), .o(a));
  xor gate_xor(.a(o), .b(a), .z(z));
endmodule

