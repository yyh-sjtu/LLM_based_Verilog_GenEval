
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output reg [2:0] out_or_bitwise,
  output reg out_or_logical,
  output reg [5:0] out_not
);

  always @* begin
    // Bitwise OR operation
    out_or_bitwise = a | b;

    // Logical OR operation
    if (a || b)
      out_or_logical = 1;
    else
      out_or_logical = 0;

    // Inverse (NOT) of a and b
    out_not[5:3] = ~b;
    out_not[2:0] = ~a;
  end

endmodule