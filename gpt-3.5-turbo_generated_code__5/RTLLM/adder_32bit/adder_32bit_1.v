module cla_16bit (
  input [15:0] A,
  input [15:0] B,
  output [16:0] S,
  output C
);

  assign G = A & B;
  assign P = A | B;
  assign C1 = G[0] | P[0] & Cin;
  assign C2 = G[1] | P[1] & C1;
  assign C3 = G[2] | P[2] & C2;
  assign C4 = G[3] | P[3] & C3;
  assign C5 = G[4] | P[4] & C4;
  assign C6 = G[5] | P[5] & C5;
  assign C7 = G[6] | P[6] & C6;
  assign C8 = G[7] | P[7] & C7;
  assign Gp = G ^ C8;
  assign Pp = P ^ C8;
  
  assign S = {C8, Gp^C7, Gp^C6, Gp^C5, Gp^C4, Gp^C3, Gp^C2, Gp^C1, Gp};
  assign C = C8;
endmodule

module adder_32bit (
  input [31:0] A,
  input [31:0] B,
  output [32:0] S,
  output C32
);

  wire [16:0] S1, S2;
  wire C1, C2;
  
  cla_16bit cl1 (.A(A[15:0]), .B(B[15:0]), .S(S1), .C(C1));
  cla_16bit cl2 (.A(A[31:16]), .B(B[31:16]), .S(S2), .C(C2));
  
  assign S = {C2, S2} + {C1, S1};
  assign C32 = C2;
endmodule

