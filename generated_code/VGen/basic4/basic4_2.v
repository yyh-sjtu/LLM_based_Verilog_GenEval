module mux(
  input [4:0] a, b,
  input sel,
  output [4:0] out
);
  
  assign out = (sel) ? b : a;
  
endmodule

