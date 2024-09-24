
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (cin & (a ^ b));

endmodule

module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output reg [7:0] sum,
    output reg cout
);

wire [6:0] carry;
wire [7:0] s;

full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(s[0]), .cout(carry[0]));
full_adder fa1 (.a(a[1]), .b(b[1]), .cin(carry[0]), .sum(s[1]), .cout(carry[1]));
full_adder fa2 (.a(a[2]), .b(b[2]), .cin(carry[1]), .sum(s[2]), .cout(carry[2]));
full_adder fa3 (.a(a[3]), .b(b[3]), .cin(carry[2]), .sum(s[3]), .cout(carry[3]));
full_adder fa4 (.a(a[4]), .b(b[4]), .cin(carry[3]), .sum(s[4]), .cout(carry[4]));
full_adder fa5 (.a(a[5]), .b(b[5]), .cin(carry[4]), .sum(s[5]), .cout(carry[5]));
full_adder fa6 (.a(a[6]), .b(b[6]), .cin(carry[5]), .sum(s[6]), .cout(carry[6]));
full_adder fa7 (.a(a[7]), .b(b[7]), .cin(carry[6]), .sum(s[7]), .cout(cout));

assign sum = s;

endmodule