
module TopModule (
  input  [3:0] a,
  input  [3:0] b,
  input  [3:0] c,
  input  [3:0] d,
  input  [3:0] e,
  output [3:0] q
);
  
  assign q = (c == 4'b0) ? b :
             (c == 4'b1 && b == 4'b0) ? e :
             (c == 4'b1 && b == 4'b1) ? a :
             (c == 4'b1 && b == 4'b3) ? d :
             f;
  
endmodule