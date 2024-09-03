module CLA_16bit (A, B, Ci, S, Co);
  input [15:0] A, B;
  input Ci;
  output [15:0] S;
  output Co;

  wire [15:0] p, g;
  wire [16:0] C;
  
  assign p = A ^ B;
  assign g = A & B;
  
  assign C[0] = g[0] | (p[0] & Ci);
  
  genvar i;
  generate
    for (i = 0; i < 15; i = i + 1) begin : gen
      assign C[i+1] = g[i+1] | (p[i+1] & C[i]);
    end
  endgenerate

  assign S = A ^ B ^ Ci;
  assign Co = g[15] | (p[15] & C[15]);
endmodule

module adder_32bit (
  input [32:1] A,
  input [32:1] B,
  output [32:1] S,
  output C32
);

  wire [31:0] Cin, Cout;
  wire [31:0] S_temp;
  wire C_out;

  CLA_16bit CLA[1:2](.A(A[16:1]), .B(B[16:1]), .Ci(Cin[0]), .S(S_temp[16:1]), .Co(Cout[0]);
  CLA_16bit CLA[3:4](.A(S_temp[16:1]), .B(B[32:17]), .Ci(Cout[0]), .S(S[32:17]), .Co(Cout[1]);

  assign Cin = 'b0;
  assign C32 = Cout[1];
  
endmodule
