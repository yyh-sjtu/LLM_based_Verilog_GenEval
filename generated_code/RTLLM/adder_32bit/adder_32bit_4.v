
module CLA_16bit (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] S,
    output Cout
);

assign P = A ^ B;
assign G = A & B;

assign c0 = Cin;
assign c1 = G[0] | (P[0] & c0);
assign c2 = G[1] | (P[1] & c1);
assign c3 = G[2] | (P[2] & c2);
assign c4 = G[3] | (P[3] & c3);
assign c5 = G[4] | (P[4] & c4);
assign c6 = G[5] | (P[5] & c5);
assign c7 = G[6] | (P[6] & c6);
assign c8 = G[7] | (P[7] & c7);
assign c9 = G[8] | (P[8] & c8);
assign c10 = G[9] | (P[9] & c9);
assign c11 = G[10] | (P[10] & c10);
assign c12 = G[11] | (P[11] & c11);
assign c13 = G[12] | (P[12] & c12);
assign c14 = G[13] | (P[13] & c13);
assign c15 = G[14] | (P[14] & c14);

assign S = A + B + Cin;
assign Cout = c15;

endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

wire [15:0] S0, S1, S2, S3;
wire C1, C2, C3, C4;

CLA_16bit clb1(.A(A[15:0]), .B(B[15:0]), .Cin(0), .S(S0), .Cout(C1));
CLA_16bit clb2(.A(A[31:16]), .B(B[31:16]), .Cin(C1), .S(S1), .Cout(C2));
CLA_16bit clb3(.A(S1), .B(S0), .Cin(C2), .S(S2), .Cout(C3));
CLA_16bit clb4(.A(A[31:16]), .B(B[31:16]), .Cin(C3), .S(S3), .Cout(C4));

assign S = {S3, S2};
assign C32 = C4;

endmodule