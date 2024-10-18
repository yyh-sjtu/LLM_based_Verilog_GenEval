module cla_16bit (
  input     [15:0] A,
  input     [15:0] B,
  output    [15:0] S,
  output    C4
);
 
wire [3:0] G,I,P,C;
 
assign G = A & B;
assign P = A ^ B;
assign I = A | B;
 
assign C[0] = G[0] | (P[0] & C[0]);
assign C[1] = G[1] | (P[1] & C[1]) | (G[0] & C[0]);
assign C[2] = G[2] | (P[2] & C[2]) | (G[1] & C[1]) | (P[1] & C[0]);
assign C[3] = G[3] | (P[3] & C[3]) | (G[2] & C[2]) | (P[2] & C[1]) | (G[0] & C[0] & G[1] & C[1]);
 
assign S = I ^ C;
assign C4 = C[3];
 
endmodule

module adder_32bit (
  input     [31:0] A,
  input     [31:0] B,
  output    [31:0] S,
  output    C32
);
 
wire [15:0] carry;
wire        C15;
 
cla_16bit u0 (
  .A(A[15:0]),
  .B(B[15:0]),
  .S(S[15:0]),
  .C4(carry[0])
);
cla_16bit u1 (
  .A(A[31:16]),
  .B(B[31:16]),
  .S(S[31:16]),
  .C4(carry[1])
);
 
assign C15 = carry[1];
 
cla_16bit u2 (
  .A(S[15:0]),
  .B(S[31:16]),
  .S(S[31:16]),
  .C4(C32)
);
 
endmodule

