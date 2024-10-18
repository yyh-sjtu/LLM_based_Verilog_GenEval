
module flipflop (
  input clk,
  input D,
  output reg Q
);
  always @(posedge clk) begin
    Q <= D;
  end
endmodule

module mux21 (
  input a,
  input b,
  input sel,
  output reg out
);
  always @(a or b or sel) begin
    if (sel)
      out <= b;
    else
      out <= a;
  end
endmodule

module TopModule (
  input clk,
  input L,
  input q_in,
  input r_in,
  output Q
);
  wire [2:0] r;
  wire L_internal;
  wire [2:0] q_internal;

  flipflop ff (
    .clk(clk),
    .D(q_in),
    .Q(q_internal[0])
  );

  mux21 mux1 (
    .a(q_internal[0]),
    .b(Q),
    .sel(r_in),
    .out(r[0])
  );

  mux21 mux2 (
    .a(r[0]),
    .b(L_internal),
    .sel(L),
    .out(r[1])
  );

  flipflop ff2 (
    .clk(clk),
    .D(q_internal[1]),
    .Q(r[2])
  );

  mux21 mux3 (
    .a(r[2]),
    .b(Q),
    .sel(r_in),
    .out(q_internal[2])
  );

  flipflop ff3 (
    .clk(clk),
    .D(q_internal[2]),
    .Q(Q)
  );

  mux21 mux4 (
    .a(r[1]),
    .b(L_internal),
    .sel(L),
    .out(L_internal)
  );

  full_module fm (
    .r(r),
    .L(L_internal),
    .clk(clk),
    .q(q_internal)
  );
endmodule