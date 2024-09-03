
module adder_8bit(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
);

wire [7:0] carry;
wire [7:0] sum_temp;

full_adder fa0(a[0], b[0], cin, sum_temp[0], carry[0]);
full_adder fa1(a[1], b[1], carry[0], sum_temp[1], carry[1]);
full_adder fa2(a[2], b[2], carry[1], sum_temp[2], carry[2]);
full_adder fa3(a[3], b[3], carry[2], sum_temp[3], carry[3]);
full_adder fa4(a[4], b[4], carry[3], sum_temp[4], carry[4]);
full_adder fa5(a[5], b[5], carry[4], sum_temp[5], carry[5]);
full_adder fa6(a[6], b[6], carry[5], sum_temp[6], carry[6]);
full_adder fa7(a[7], b[7], carry[6], sum_temp[7], cout);

assign sum = sum_temp;

endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign {cout, sum} = a + b + cin;

endmodule