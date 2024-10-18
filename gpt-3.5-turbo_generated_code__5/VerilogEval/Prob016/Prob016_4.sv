
module FullAdder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);

  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] carry;
  wire[3:0] adder_sum;

  FullAdder fa0(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(adder_sum[0]), .cout(carry[0]));
  FullAdder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(adder_sum[1]), .cout(carry[1]));
  FullAdder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(adder_sum[2]), .cout(carry[2]));
  FullAdder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(adder_sum[3]), .cout(carry[3]));

  assign sum = {carry[3], adder_sum};

endmodule