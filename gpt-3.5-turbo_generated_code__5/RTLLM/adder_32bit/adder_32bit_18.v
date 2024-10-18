module cla_16bit (
    input [15:0] A,
    input [15:0] B,
    output [15:0] S,
    output C
);

// Carry generation and propagation
assign P = A & B;
assign G = A | B;
assign P[G] = 1'b0;

assign C_propagate = A ^ B;
assign C_generate = P | (G & C_propagate);
assign C_in = 1'b0;
assign C_out = G | (P & C_in);

// Generate sum
assign S = A ^ B ^ C_in;

// Generate carry-out
assign C = C_out;

endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

wire [15:0] c0;
wire [15:0] c1;
wire [15:0] c2;
wire [15:0] c3;
wire [15:0] s0;
wire [15:0] s1;
wire [15:0] s2;
wire [15:0] s3;

cla_16bit u1(
    .A(A[15:0]),
    .B(B[15:0]),
    .S(s0),
    .C(c0)
);

cla_16bit u2(
    .A(A[31:16]),
    .B(B[31:16]),
    .S(s1),
    .C(c1)
);

cla_16bit u3(
    .A(s0),
    .B(s1),
    .S(s2),
    .C(c2)
);

cla_16bit u4(
    .A(A[31:16]),
    .B(B[31:16]),
    .S(s3),
    .C(c3)
);

assign S = {s3, s2, s1, s0};
assign C32 = c3;

endmodule

