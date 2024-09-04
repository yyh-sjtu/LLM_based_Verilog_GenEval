module cla_16bit(
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] S,
    output Cout
);

assign G = A & B;
assign P = A ^ B;
assign GG = G | (P & Cin);
assign PP = P & Cin;
assign S = GG ^ Cin;
assign Cout = GG | PP;

endmodule

module adder_32bit(
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

cla_16bit cla0(
    .A(A[15:0]),
    .B(B[15:0]),
    .Cin(1'b0),
    .S(S[15:0]),
    .Cout(cout0)
);

cla_16bit cla1(
    .A(A[31:16]),
    .B(B[31:16]),
    .Cin(cout0),
    .S(S[31:16]),
    .Cout(C32)
);

endmodule

