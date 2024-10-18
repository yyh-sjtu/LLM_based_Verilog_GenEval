
// TopModule with XNOR gate implementation

module TopModule (
  input a,
  input b,
  output reg out
);
  
  // XNOR gate implementation
  assign out = ~(a ^ b);
  
endmodule