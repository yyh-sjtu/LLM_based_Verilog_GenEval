
module full_adder(
    input a,
    input b,
    input Cin,
    output sum,
    output Co
);

assign sum = a ^ b ^ Cin;
assign Co = (a & b) | (Cin & (a ^ b));

endmodule

module adder_16bit(
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] carry;
wire [7:0] sum;

full_adder fa0(.a(a[0]), .b(b[0]), .Cin(Cin), .sum(sum[0]), .Co(carry[0]));
full_adder fa1(.a(a[1]), .b(b[1]), .Cin(carry[0]), .sum(sum[1]), .Co(carry[1]));
full_adder fa2(.a(a[2]), .b(b[2]), .Cin(carry[1]), .sum(sum[2]), .Co(carry[2]));
full_adder fa3(.a(a[3]), .b(b[3]), .Cin(carry[2]), .sum(sum[3]), .Co(carry[3]));
full_adder fa4(.a(a[4]), .b(b[4]), .Cin(carry[3]), .sum(sum[4]), .Co(carry[4]));
full_adder fa5(.a(a[5]), .b(b[5]), .Cin(carry[4]), .sum(sum[5]), .Co(carry[5]));
full_adder fa6(.a(a[6]), .b(b[6]), .Cin(carry[5]), .sum(sum[6]), .Co(carry[6]));
full_adder fa7(.a(a[7]), .b(b[7]), .Cin(carry[6]), .sum(sum[7]), .Co(carry[7]));
full_adder fa8(.a(a[8]), .b(b[8]), .Cin(carry[7]), .sum(sum[8]), .Co(Co));
full_adder fa9(.a(a[9]), .b(b[9]), .Cin(Co), .sum(sum[9]), .Co(carry[0]));
full_adder fa10(.a(a[10]), .b(b[10]), .Cin(carry[0]), .sum(sum[10]), .Co(carry[1]));
full_adder fa11(.a(a[11]), .b(b[11]), .Cin(carry[1]), .sum(sum[11]), .Co(carry[2]));
full_adder fa12(.a(a[12]), .b(b[12]), .Cin(carry[2]), .sum(sum[12]), .Co(carry[3]));
full_adder fa13(.a(a[13]), .b(b[13]), .Cin(carry[3]), .sum(sum[13]), .Co(carry[4]));
full_adder fa14(.a(a[14]), .b(b[14]), .Cin(carry[4]), .sum(sum[14]), .Co(carry[5]));
full_adder fa15(.a(a[15]), .b(b[15]), .Cin(carry[5]), .sum(sum[15]), .Co(carry[6]));

assign y = sum;

endmodule