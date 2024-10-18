
module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output [3:0] q
);

  always @* begin
    if (c == b)        // Check if c is equal to b
      q <= 4'df;
    else if (d == e)   // Check if d is equal to e
      q <= 4'df;
    else if (a > 9)    // Check if a is greater than 9
      q <= 4'df;
    else if (b > 9)    // Check if b is greater than 9
      q <= 4'df;
    else              // Otherwise, set q as e
      q <= e;
  end

endmodule