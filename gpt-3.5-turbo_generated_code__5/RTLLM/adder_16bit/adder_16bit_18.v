module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output [7:0] sum,
    output Co
);

assign {Co,sum} = a + b + Cin;

endmodule

module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

    wire [7:0] c0;
    wire [7:0] c1;
    wire [7:0] c2;
    wire [7:0] c3;
    wire Co1;
    wire Co2;
    wire Co3;

    adder_8bit adder0 (
        .a(a[7:0]),
        .b(b[7:0]),
        .Cin(Cin),
        .sum(y[7:0]),
        .Co(Co1)
    );

    adder_8bit adder1 (
        .a(a[7:0]),
        .b(b[7:0]),
        .Cin(Co1),
        .sum(y[15:8]),
        .Co(Co2)
    );

    adder_8bit adder2 (
        .a(a[7:0]),
        .b(b[7:0]),
        .Cin(Co2),
        .sum(y[7:0]),
        .Co(Co3)
    );

    assign Co = Co3;

endmodule

