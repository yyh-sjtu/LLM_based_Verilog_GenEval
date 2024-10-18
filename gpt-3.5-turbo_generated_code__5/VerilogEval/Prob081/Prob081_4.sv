
module TopModule (
  input p1a, input p1b, input p1c, input p1d, input p1e, input p1f,
  input p2a, input p2b, input p2c, input p2d, 
  output p1y, output p2y
);

  wire p1y_internal, p2y_internal;

  assign p1y_internal = p1a & p1b & p1c | p1d & p1e & p1f; // OR-ing two 3-input AND gates
  assign p2y_internal = p2a & p2b | p2c & p2d; // OR-ing two 2-input AND gates

  assign p1y = p1y_internal;
  assign p2y = p2y_internal;
  
endmodule