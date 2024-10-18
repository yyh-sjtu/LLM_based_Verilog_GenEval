
module TopModule (
  input  [3:0] x,
  output f
);

  assign f = (x[3] & x[2]) | (!x[3] & !x[2] & !x[0]);

endmodule