
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output [7:0] y,
    output Co
);

assign y = a + b + Cin;
assign Co = (a[7] & b[7]) | (a[7] & Cin) | (b[7] & Cin);

endmodule

module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

reg [7:0] sum1, sum2, sum3;
wire Co1, Co2;

adder_8bit adder1(
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Cin),
    .y(sum1),
    .Co(Co1)
);
adder_8bit adder2(
    .a(a[8:15]),
    .b(b[8:15]),
    .Cin(Co1),
    .y(sum2),
    .Co(Co2)
);
adder_8bit adder3(
    .a({1'b0, sum2}),
    .b({1'b0, sum3}),
    .Cin(Co2),
    .y(y),
    .Co(Co)
);

endmodule