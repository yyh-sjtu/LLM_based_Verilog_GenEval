module cla_16bit (
  input [16:1] A,
  input [16:1] B,
  output [16:1] S,
  output C
);

  assign generate[4:1] = A[4:1] & B[4:1];
  assign propagate[4:1] = A[4:1] | B[4:1];

  assign P[4:1] = A[4:1] ^ B[4:1];
  assign G[4:1] = A[4:1] & B[4:1];

  assign P[3] = P[4] ^ (A[3] ^ B[3]);
  assign G[3] = G[4] | (P[4] & (A[3] ^ B[3]));

  assign P[2] = P[3] ^ (A[2] ^ B[2]);
  assign G[2] = G[3] | (P[3] & (A[2] ^ B[2]));

  assign P[1] = P[2] ^ (A[1] ^ B[1]);
  assign G[1] = G[2] | (P[2] & (A[1] ^ B[1]));

  assign C = G[1] | (P[1] & (A[1] ^ B[1]));

  assign S[4:1] = A[4:1] ^ B[4:1];
  assign S[3] = P[3] ^ (A[3] ^ B[3]);
  assign S[2] = P[2] ^ (A[2] ^ B[2]);
  assign S[1] = P[1] ^ (A[1] ^ B[1]);

endmodule

module adder_32bit (
  input [32:1] A,
  input [32:1] B,
  output [32:1] S,
  output C32
);

  cla_16bit cla1(
    .A(A[16:1]),
    .B(B[16:1]),
    .S(S[16:1]),
    .C(c1)
  );

  cla_16bit cla2(
    .A(A[32:17]),
    .B(B[32:17]),
    .S(S[32:17]),
    .C(c2)
  );

  assign cin = c1 | (c2 & c1);
  assign C32 = c2;

endmodule

