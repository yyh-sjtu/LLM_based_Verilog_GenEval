
module FullAdder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (cin & (a ^ b));

endmodule

module TopModule (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry;
FullAdder FA0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));
FullAdder FA1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
FullAdder FA2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
FullAdder FA3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(sum[4]));

endmodule