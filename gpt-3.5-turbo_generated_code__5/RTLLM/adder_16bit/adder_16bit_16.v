module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] y,
    output co
);

assign {co, y} = a + b + cin;

endmodule

module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] y,
    output co
);

wire [7:0] carry_out;
wire [7:0] sum;

adder_8bit adder1 (
    .a(a[7:0]),
    .b(b[7:0]),
    .cin(cin),
    .y(y[7:0]),
    .co(carry_out[0])
);

adder_8bit adder2 (
    .a(a[15:8]),
    .b(b[15:8]),
    .cin(carry_out[0]),
    .y(y[15:8]),
    .co(carry_out[1])
);

assign co = carry_out[1];
assign y = {sum, carry_out};

endmodule

