
module TopModule (
  input  wire a,
  input  wire b,
  input  wire sel,
  output wire out
);
  
  // implementation of 2-to-1 multiplexer
  assign out = (sel == 1'b0) ? a : b;
  
endmodule