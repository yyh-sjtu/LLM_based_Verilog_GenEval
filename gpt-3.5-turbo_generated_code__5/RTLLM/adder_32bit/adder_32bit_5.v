module adder_32bit (
  input [32:1] A, B,
  output [32:1] S,
  output C32
);

  wire [16:1] G;
  wire [16:1] P;
  wire [16:1] C;

  // First 16-bit CLA block
  cla_16bit cla1(A[16:1], B[16:1], S[16:1], C[16], G[16:1], P[16:1]);

  // Second 16-bit CLA block
  cla_16bit cla2(A[32:17], B[32:17], S[32:17], C[17], G[17:2], P[17:2]);

  // Generate the carries for the 32-bit adder
  gen_carry genCarry(G, C);

  // Generate the sum bits for the 32-bit adder
  gen_sum genSum(G, P, C, S);

  // Output the final carry bit
  assign C32 = C[16];

endmodule

module cla_16bit (
  input [16:1] A, B,
  output [16:1] S,
  output C,
  output [16:1] G,
  output [16:1] P
);

  wire [16:1] Carry;

  // Generate Generate (G) and Propagate (P) signals
  gen_generate genGen(A, B, G);
  gen_propagate genProp(A, B, P);

  // Generate Carry signals for each bit position
  gen_carry genCarry(G, Carry);

  // Generate Sum (S) bits for each bit position
  gen_sum genSum(G, P, Carry, S);

  // Output Carry for this block
  assign C = Carry[16];

endmodule

module gen_generate (
  input [16:1] A, B,
  output [16:1] G
);

  // Generate (G) = A & B
  assign G = A & B;

endmodule

module gen_propagate (
  input [16:1] A, B,
  output [16:1] P
);

  // Propagate (P) = A | B
  assign P = A | B;

endmodule

module gen_carry (
  input [16:1] G,
  output [16:1] C
);

  // Carry (C) signals generation
  assign C[16] = G[16];
  assign C[15] = G[15] | (G[16] & G[14]);
  assign C[14] = G[14] | (G[16] & G[13]) | (G[15] & G[13]);
  assign C[13] = G[13] | (G[16] & G[12]) | (G[15] & G[12]) | (G[14] & G[12]);
  assign C[12] = G[12] | (G[16] & G[11]) | (G[15] & G[11]) | (G[14] & G[11]) | (G[13] & G[11]);
  assign C[11] = G[11] | (G[16] & G[10]) | (G[15] & G[10]) | (G[14] & G[10]) | (G[13] & G[10]) | (G[12] & G[10]);
  assign C[10] = G[10] | (G[16] & G[9]) | (G[15] & G[9]) | (G[14] & G[9]) | (G[13] & G[9]) | (G[12] & G[9]) | (G[11] & G[9]);
  assign C[9] = G[9] | (G[16] & G[8]) | (G[15] & G[8]) | (G[14] & G[8]) | (G[13] & G[8]) | (G[12] & G[8]) | (G[11] & G[8]) | (G[10] & G[8]);
  assign C[8] = G[8] | (G[16] & G[7]) | (G[15] & G[7]) | (G[14] & G[7]) | (G[13] & G[7]) | (G[12] & G[7]) | (G[11] & G[7]) | (G[10] & G[7]) | (G[9] & G[7]);
  assign C[7] = G[7] | (G[16] & G[6]) | (G[15] & G[6]) | (G[14] & G[6]) | (G[13] & G[6]) | (G[12] & G[6]) | (G[11] & G[6]) | (G[10] & G[6]) | (G[9] & G[6]) | (G[8] & G[6]);
  assign C[6] = G[6] | (G[16] & G[5]) | (G[15] & G[5]) | (G[14] & G[5]) | (G[13] & G[5]) | (G[12] & G[5]) | (G[11] & G[5]) | (G[10] & G[5]) | (G[9] & G[5]) | (G[8] & G[5]) | (G[7] & G[5]);
  assign C[5] = G[5] | (G[16] & G[4]) | (G[15] & G[4]) | (G[14] & G[4]) | (G[13] & G[4]) | (G[12] & G[4]) | (G[11] & G[4]) | (G[10] & G[4]) | (G[9] & G[4]) | (G[8] & G[4]) | (G[7] & G[4]) | (G[6] & G[4]);
  assign C[4] = G[4] | (G[16] & G[3]) | (G[15] & G[3]) | (G[14] & G[3]) | (G[13] & G[3]) | (G[12] & G[3]) | (G[11] & G[3]) | (G[10] & G[3]) | (G[9] & G[3]) | (G[8] & G[3]) | (G[7] & G[3]) | (G[6] & G[3]) | (G[5] & G[3]);
  assign C[3] = G[3] | (G[16] & G[2]) | (G[15] & G[2]) | (G[14] & G[2]) | (G[13] & G[2]) | (G[12] & G[2]) | (G[11] & G[2]) | (G[10] & G[2]) | (G[9] & G[2]) | (G[8] & G[2]) | (G[7] & G[2]) | (G[6] & G[2]) | (G[5] & G[2]) | (G[4] & G[2]);
  assign C[2] = G[2] | (G[16] & G[1]) | (G[15] & G[1]) | (G[14] & G[1]) | (G[13] & G[1]) | (G[12] & G[1]) | (G[11] & G[1]) | (G[10] & G[1]) | (G[9] & G[1]) | (G[8] & G[1]) | (G[7] & G[1]) | (G[6] & G[1]) | (G[5] & G[1]) | (G[4] & G[1]) | (G[3] & G[1]);
  assign C[1] = G[1] | (G[16] & G[1]) | (G[15] & G[1]) | (G[14] & G[1]) | (G[13] & G[1]) | (G[12] & G[1]) | (G[11] & G[1]) | (G[10] & G[1]) | (G[9] & G[1]) | (G[8] & G[1]) | (G[7] & G[1]) | (G[6] & G[1]) | (G[5] & G[1]) | (G[4] & G[1]) | (G[3] & G[1]) | (G[2] & G[1]);

endmodule

