module CLA_16bit(
  input [15:0] A,
  input [15:0] B,
  output [15:1] S,
  output C
);
  
  wire [16:1] G;
  wire [15:1] P;
  wire [16:1] C;
  
  CLA_4bit C1(A[3:0], B[3:0], G[4:1], P[3:0], C[4:1]);
  CLA_4bit C2(A[7:4], B[7:4], G[8:5], P[7:4], C[8:5]);
  CLA_4bit C3(A[11:8], B[11:8], G[12:9], P[11:8], C[12:9]);
  CLA_4bit C4(A[15:12], B[15:12], G[16:13], P[15:12], C[16:13]);
  
  assign S = {C4[16], C4[15], C4[14], C4[13], C3[12], C3[11], C3[10], C3[9], C2[8], C2[7], C2[6], C2[5], C1[4], C1[3], C1[2], C1[1]};
  assign C = C4[16];
  
endmodule

module CLA_4bit(
  input [3:0] A,
  input [3:0] B,
  output [4:1] G,
  output [3:0] P,
  output [4:1] C
);
  
  wire [4:1] G0, G1, G2, G3;
  wire [3:0] P0, P1, P2, P3;
  wire [4:1] C0, C1, C2, C3;
  
  generate
    generate
      gen_GenerateGroup0: for (i = 1; i <= 4; i=i+1) begin : GG0
        assign G0[i] = A[i] & B[i];
        assign P0[i] = A[i] | B[i];
        assign C0[i] = A[i] ^ B[i];
      end
    endgenerate
    
    gen_GenerateGroup1: for (i = 1; i <= 4; i=i+1) begin : GG1
      assign G1[i] = G0[i-1] & C0[i-1];
      assign P1[i] = P0[i-1] | (G0[i-1] & C0[i-1]);
      assign C1[i] = G0[i-1] | (P0[i-1] & C0[i-1]);
    end
    generate
  
    gen_GenerateGroup2: for (i = 1; i <= 4; i=i+1) begin : GG2
      assign G2[i] = G1[i-1] & C1[i-1];
      assign P2[i] = P1[i-1] | (G1[i-1] & C1[i-1]);
      assign C2[i] = G1[i-1] | (P1[i-1] & C1[i-1]);
    end
    generate
  
    gen_GenerateGroup3: for (i = 1; i <= 4; i=i+1) begin : GG3
      assign G3[i] = G2[i-1] & C2[i-1];
      assign P3[i] = P2[i-1] | (G2[i-1] & C2[i-1]);
      assign C3[i] = G2[i-1] | (P2[i-1] & C2[i-1]);
    end
  endgenerate
  
  assign {G[4],G[3],G[2],G[1]} = G3;
  assign {P[3],P[2],P[1],P[0]} = P3;
  assign {C[4],C[3],C[2],C[1]} = C3;
  
endmodule

module adder_32bit(
  input [32:1] A,
  input [32:1] B,
  output [32:1] S,
  output C32
);
  
  wire [16:1] G;
  wire [15:1] P;
  wire [16:1] C;
  
  CLA_16bit C1(A[16:1], B[16:1], G[16:1], P[15:1], C[16:1]);
  CLA_16bit C2(A[32:17], B[32:17], G[32:17], P[31:16], C[32:17]);
  
  assign S[32] = C[32];
  assign S[31:16] = P[16:1];
  assign S[15:1] = P[15:1] ^ G[16:1];
  assign C32 = C[32];
  
endmodule

