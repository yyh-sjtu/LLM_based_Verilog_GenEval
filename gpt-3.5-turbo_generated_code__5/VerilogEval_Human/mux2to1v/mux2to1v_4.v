module mux_2to1 (
   input [99:0] a,
   input [99:0] b,
   input sel,
   output [99:0] out
);

   assign out = sel ? b : a;

endmodule

module top_module (
   input [99:0] a,
   input [99:0] b,
   input sel,
   output [99:0] out
);

   mux_2to1 u1 (.a(a), .b(b), .sel(sel), .out(out));

endmodule

