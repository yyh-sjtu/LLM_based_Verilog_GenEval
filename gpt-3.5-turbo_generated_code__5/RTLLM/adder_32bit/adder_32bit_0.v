
module adder_32bit(
  input [31:0] A,
  input [31:0] B,
  output [31:0] S,
  output C32
);
  
  wire [31:0] C;
  
  wire [31:0] P, G;
  
  // Instantiation of 16-bit CLA blocks
  cla_block_16bit u1(
    .A(A[15:0]),
    .B(B[15:0]),
    .Cin(0),
    .P(P[15:0]),
    .G(G[15:0])
  );
  
  cla_block_16bit u2(
    .A(A[31:16]),
    .B(B[31:16]),
    .Cin(P[15]),
    .P(P[31:16]),
    .G(G[31:16])
  );

  // Generate and propagate signals for 32-bit addition
  wire [31:0] Pg, Gg;
  wire [31:0] Pgout, Cout;  
  
  genpropagate16 #(16, 2) u3(
    .P(G),
    .G(P),
    .Pout(Pg),
    .Gout(Gg)
  );
  
  genpropagate16 #(32, 4) u4(
    .P(Pg),
    .G(Gg),
    .Pout(Pgout),
    .Gout(Cout)
  );
  
  assign C32 = Cout[31];
  assign S = Pgout;
  
endmodule