module mux_2to1 (
    input a,
    input b,
    input sel,
    output out
);

  assign out = (sel == 0) ? a : b;

endmodule

module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

  wire [99:0] out_wire;
  mux_2to1 mux (.a(a), .b(b), .sel(sel), .out(out_wire));

  assign out = out_wire;

endmodule

