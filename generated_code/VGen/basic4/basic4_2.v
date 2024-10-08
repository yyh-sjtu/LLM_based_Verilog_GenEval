module mux( 
  input [4:0] a, b,
  input sel,
  output [4:0] out );
  
  assign out = (sel == 1'b0) ? a : b;
  
endmodule

