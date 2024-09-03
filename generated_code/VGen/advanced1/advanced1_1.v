
module signed_adder(
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

reg[7:0] temp;

assign s = a + b; // regular addition of the two 8-bit inputs

// logic to check for signed overflow
always @* begin
  temp = a + b;
  if ((a[7] == b[7]) && (a[7] != temp[7])) // overflow occurs if signs of operands are the same and result has a different sign
    overflow = 1;
  else
    overflow = 0;
end

endmodule