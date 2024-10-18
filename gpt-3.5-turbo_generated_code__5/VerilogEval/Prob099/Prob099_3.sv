
module TopModule (
  input [6:0] y,
  input w,
  output Y1,
  output Y3
);
  
  wire Y2, Y4;
  
  // State A
  assign Y2 = ~y[1] & ~y[3];
  assign Y4 = ~y[1] & ~y[3];
  
  // State B
  assign Y2 = y[1] & ~y[3];
  assign Y4 = y[1] & ~y[3];
  
  // State C
  assign Y2 = ~y[1] & y[3];
  assign Y4 = ~y[1] & y[3];
  
  // State D
  assign Y2 = y[1] & y[3];
  assign Y4 = y[1] & y[3];
  
  // State E
  assign Y2 = ~y[1] & ~y[3];
  assign Y4 = y[1] & y[3];
  
  // State F
  assign Y2 = y[1] & y[3];
  assign Y4 = ~y[1] & y[3];
  
  // Output assignments
  assign Y1 = Y2;
  assign Y3 = Y4;
  
endmodule