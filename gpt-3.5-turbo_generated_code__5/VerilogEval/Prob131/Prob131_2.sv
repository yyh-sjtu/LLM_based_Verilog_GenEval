
module A (
  input x,
  input y,
  output z
);
  assign z = (x & y);
endmodule

module B(
  input x,
  input y,
  output z
);
  assign z = (x | y);
endmodule

module TopModule (
  input x,
  input y,
  output z
);
  wire or_out, and_out;
  
  A a1(.x(x), .y(y), .z(and_out));
  B b1(.x(x), .y(y), .z(or_out));
  
  A a2(.x(x), .y(y), .z(and_out));
  B b2(.x(x), .y(y), .z(or_out));
  
  assign z = (or_out ^ and_out);
endmodule