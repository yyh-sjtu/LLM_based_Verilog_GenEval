module cla_16bit (
    input [15:0] A,
    input [15:0] B,
    output [15:0] S,
    output C
);

assign G = A & B;
assign P = A | B;
assign GG = G + (P << 1);
assign PP = P;
assign S = GG + PP;
assign C = G | (P & C_in);

endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

wire [15:0] carry;
wire [15:0] sum_1, sum_2, sum_3, sum_4;

cla_16bit u1 (.A(A[15:0]), .B(B[15:0]), .S(sum_1), .C(carry[0]));
cla_16bit u2 (.A(A[31:16]), .B(B[31:16]), .S(sum_2), .C(carry[1]));
cla_16bit u3 (.A(sum_1), .B(sum_2), .S(sum_3), .C(carry[2]));
cla_16bit u4 (.A(A[31:16]), .B(B[31:16]), .S(sum_4), .C(carry[3]));

assign S = {sum_4, sum_3, sum_2, sum_1};
assign C32 = carry[3];

endmodule

