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

wire [7:0] c0, c1, c2, c3;
wire Co3;

adder_8bit adder0(.a(a[7:0]), .b(b[7:0]), .Cin(Cin), .y(y[7:0]), .Co(c0));
adder_8bit adder1(.a(a[7:0]), .b(b[7:0]), .Cin(c0), .y(y[7:0], .Co(c1));
adder_8bit adder2(.a(a[7:0]), .b(b[7:0]), .Cin(c1), .y(y[7:0], .Co(c2));
adder_8bit adder3(.a(a[7:0]), .b(b[7:0]), .Cin(c2), .y(y[7:0], .Co(Co3));

adder_8bit adder4(.a(a[15:8]), .b(b[15:8]), .Cin(Co3), .y(y[15:8]), .Co(Co));

endmodule
