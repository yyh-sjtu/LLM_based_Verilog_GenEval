module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
 );

wire [7:0] carry;
wire [7:0] sum;

// First stage of 8-bit adders
full_adder_8bit fa_stage_0 (
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Cin),
    .y(sum[7:0]),
    .Co(carry[0])
);

// Second stage of 8-bit adders
full_adder_8bit fa_stage_1 (
    .a(a[15:8]),
    .b(b[15:8]),
    .Cin(carry[0]),
    .y(sum[15:8]),
    .Co(carry[1])
);

// Combining the carry-out results
assign Co = carry[1];

// Output sum
assign y = sum;

endmodule

module full_adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output [7:0] y,
    output Co
);

wire [6:0] carry;
wire [6:0] sum;

assign carry[0] = Cin;
// First stage of 4-bit adders
full_adder_4bit fa_stage_0 (
    .a(a[3:0]),
    .b(b[3:0]),
    .Cin(Cin),
    .y(sum[3:0]),
    .Co(carry[1])
);

// Second stage of 4-bit adders
full_adder_4bit fa_stage_1 (
    .a(a[7:4]),
    .b(b[7:4]),
    .Cin(carry[1]),
    .y(sum[7:4]),
    .Co(carry[2])
);

assign Co = carry[2];

// Output sum
assign y = sum;

endmodule

module full_adder_4bit (
    input [3:0] a,
    input [3:0] b,
    input Cin,
    output [3:0] y,
    output Co
);

wire c1, c2, c3;

// 4-bit adder logic
assign {Co, y} = a + b + Cin;

endmodule

