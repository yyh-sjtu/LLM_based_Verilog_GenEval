module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output [7:0] y,
    output Co
);

assign {Co, y} = a + b + Cin;

endmodule

module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] co_temp;
wire [7:0] y_temp1, y_temp2;

adder_8bit adder1 (
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Cin),
    .y(y_temp1),
    .Co(co_temp[0])
);

adder_8bit adder2 (
    .a(a[15:8]),
    .b(b[15:8]),
    .Cin(co_temp[0]),
    .y(y_temp2),
    .Co(Co)
);

assign y = {y_temp2, y_temp1};

endmodule

