
module cla_16bit (
    input [15:0] A,
    input [15:0] B,
    output [15:0] S,
    output C
);

assign G = A & B;
assign P = A ^ B;
assign Gp = G + P;

assign S = Gp ^ P;
assign C = G | (P & C);

endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

wire [15:0] c_in;
wire [15:0] c_out;

cla_16bit cla0 (.A(A[15:0]), .B(B[15:0]), .S(S[15:0]), .C(c_in[0]));
cla_16bit cla1 (.A(A[31:16]), .B(B[31:16]), .S(S[31:16]), .C(c_in[1]));

cla_16bit cla2 (.A(S[15:0]), .B(c_in), .S(S[15:0]), .C(c_out[0]));
cla_16bit cla3 (.A(S[31:16]), .B(c_out), .S(S[31:16]), .C(C32));

endmodule