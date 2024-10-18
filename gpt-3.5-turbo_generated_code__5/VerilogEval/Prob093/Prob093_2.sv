
module TopModule(
  input c,
  input d,
  output [3:0] mux_in
);

  wire [1:0] ab;
  wire [1:0] x;
  wire [1:0] y;

  assign ab = {c, d};
  assign x[0] = (~c & ~d);
  assign x[1] = (c & ~d);
  assign x[2] = (c & d);
  assign x[3] = (~c & d);

  assign y[0] = (~x[0] & ab[0]);
  assign y[1] = (~x[1] & ab[0]);
  assign y[2] = (x[2] & ab[0]);
  assign y[3] = (x[3] & ab[0]);

  assign mux_in[0] = (~y[0] & ab[1]);
  assign mux_in[1] = (~y[1] & ab[1]);
  assign mux_in[2] = (y[2] & ab[1]);
  assign mux_in[3] = (y[3] & ab[1]);

endmodule