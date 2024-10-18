
module CLA16bit (
  input [15:0] A, B,
  output [15:0] S,
  output C
);
  
  wire [15:0] P, G;
  wire [3:0] C_propagate, C_generate;
  
  generate
    genvar i;
    for (i=0; i<16; i=i+1) begin: gen_CLA
      assign P[i] = A[i] ^ B[i];
      assign G[i] = A[i] & B[i];
      assign C_propagate[i] = A[i] | B[i];
    end
  endgenerate
  
  assign C_generate[0] = A[0] & B[0];
  assign C_generate[1] = G[0] & C_generate[0];
  assign C_generate[2] = G[1] & C_generate[1];
  assign C_generate[3] = G[2] & C_generate[2];
  
  assign C = C_propagate[15] | C_generate[3];
  
  assign S[0] = P[0] ^ C;
  assign S[1] = P[1] ^ C_generate[0];
  assign S[2] = P[2] ^ C_generate[1];
  assign S[3] = P[3] ^ C_generate[2];
  
endmodule


module adder_32bit (
  input [32:1] A, B,
  output [32:1] S,
  output C32
);
  
  wire [15:0] C1, C2;
  wire [15:0] S1, S2;
  
  CLA16bit C0 (
    .A(A[16:1]),
    .B(B[16:1]),
    .S(S[16:1]),
    .C(C1[15])
  );
  
  CLA16bit C3 (
    .A(A[32:17]),
    .B(B[32:17]),
    .S(S[32:17]),
    .C(C2[15])
  );
  
  CLA16bit C4 (
    .A(S[16:1]),
    .B(S[32:17]),
    .S(S1),
    .C(C32)
  );
  
  CLA16bit C5 (
    .A(C1),
    .B(C2),
    .S(S2),
    .C(C32)
  );
  
  assign S[32] = C32;
  assign S[16:1] = S1;
  assign S[32:17] = S2;
  
endmodule