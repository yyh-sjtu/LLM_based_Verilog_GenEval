
module adder_8bit(
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output [7:0] y,
    output Co
);

assign {Co, y} = a + b + Cin;

endmodule

module adder_16bit(
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] sum1, sum2, sum3;
wire Co1, Co2;

adder_8bit adder1(
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Cin),
    .y(sum1),
    .Co(Co1)
);

adder_8bit adder2(
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Co1),
    .y(sum2),
    .Co(Co2)
);

adder_8bit adder3(
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Co2),
    .y(sum3),
    .Co(Co)
);

assign y = {sum3, sum2};
  
endmodule