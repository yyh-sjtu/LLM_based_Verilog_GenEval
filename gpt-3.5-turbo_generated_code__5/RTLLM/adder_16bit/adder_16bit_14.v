
module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] carry;
wire [7:0] sum;

// Instantiate 8-bit adders
adder_8bit add0 (.a(a[7:0]), .b(b[7:0]), .Cin(Cin), .sum(sum[0]), .Co(carry[0]));
adder_8bit add1 (.a(a[15:8]), .b(b[15:8]), .Cin(carry[0]), .sum(sum[1]), .Co(carry[1]));
//
// Add more instances here (add2, add3, add4, ..., add7)
//
adder_8bit add7 (.a(a[119:112]), .b(b[119:112]), .Cin(carry[6]), .sum(sum[7]), .Co(Co));

assign y = {sum[7], sum[6], sum[5], sum[4], sum[3], sum[2], sum[1], sum[0]};

endmodule