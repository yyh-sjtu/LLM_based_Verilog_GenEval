
module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] carry;
wire [15:0] sum;

// First 8-bit adder
full_adder_8bit add1(
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Cin),
    .y(sum[7:0]),
    .Co(carry[0])
);

// Second 8-bit adder
full_adder_8bit add2(
    .a(a[15:8]),
    .b(b[15:8]),
    .Cin(carry[0]),
    .y(sum[15:8]),
    .Co(carry[1])
);

assign y = sum;
assign Co = carry[1];

endmodule