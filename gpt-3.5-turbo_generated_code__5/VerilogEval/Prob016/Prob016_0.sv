
module FullAdder(
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule


module TopModule(
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] s_intermediate;
  wire carry;

  FullAdder fa0(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(s_intermediate[0]), .cout(carry));
  FullAdder fa1(.a(x[1]), .b(y[1]), .cin(carry), .sum(s_intermediate[1]), .cout(carry));
  FullAdder fa2(.a(x[2]), .b(y[2]), .cin(carry), .sum(s_intermediate[2]), .cout(carry));
  FullAdder fa3(.a(x[3]), .b(y[3]), .cin(carry), .sum(s_intermediate[3]), .cout(carry));

  assign sum = {carry, s_intermediate};

endmodule