
module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] c;
wire [15:0] s;

// Instantiate 8-bit adder module
adder_8bit adder0 (
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Cin),
    .y(s[7:0]),
    .Co(c[0])
);
adder_8bit adder1 (
    .a(a[15:8]),
    .b(b[15:8]),
    .Cin(c[0]),
    .y(s[15:8]),
    .Co(c[1])
);

assign y = s;
assign Co = c[1];

endmodule

module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output [7:0] y,
    output Co
);

reg [7:0] sum;

always @* begin
    sum = a + b + Cin;
end

assign y = sum;
assign Co = sum[8];

endmodule