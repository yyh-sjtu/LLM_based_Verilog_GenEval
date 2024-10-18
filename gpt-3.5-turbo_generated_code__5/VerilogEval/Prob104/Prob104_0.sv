
module flipflop (
  input clk,
  input D,
  input reset,
  output reg Q
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      Q <= 0;
    end else begin
      Q <= D;
    end
  end

endmodule


module mux_2to1 (
  input S,
  input D0,
  input D1,
  output Y
);

  assign Y = (S == 0) ? D0 : D1;

endmodule


module TopModule (
  input clk,
  input L,
  input q_in,
  input r_in,
  output Q
);

  wire [2:0] r;
  wire [2:0] q;

  flipflop FF1 (
    .clk(clk),
    .D(q_in),
    .reset(L),
    .Q(q[0])
  );

  flipflop FF2 (
    .clk(clk),
    .D(q[0]),
    .reset(L),
    .Q(q[1])
  );

  flipflop FF3 (
    .clk(clk),
    .D(q[1]),
    .reset(L),
    .Q(q[2])
  );

  mux_2to1 mux (
    .S(r_in),
    .D0(q[1] ^ q[2]),
    .D1(q[0]),
    .Y(Q)
  );

  full_module full_mod (
    .r(r),
    .L(L),
    .clk(clk),
    .q(q)
  );

endmodule


module TopLevelModule (
  input clk,
  input L,
  input q_in,
  input r_in,
  output Q_A,
  output Q_B,
  output Q_C
);

  wire Q1, Q2, Q3;

  TopModule TM1 (
    .clk(clk),
    .L(L),
    .q_in(q_in),
    .r_in(r_in),
    .Q(Q1)
  );

  TopModule TM2 (
    .clk(clk),
    .L(L),
    .q_in(q_in),
    .r_in(r_in),
    .Q(Q2)
  );

  TopModule TM3 (
    .clk(clk),
    .L(L),
    .q_in(q_in),
    .r_in(r_in),
    .Q(Q3)
  );

  assign Q_A = Q1;
  assign Q_B = Q2;
  assign Q_C = Q3;

endmodule