
module cla_adder_4bit (
  input [3:0] A,
  input [3:0] B,
  output [3:0] S,
  output C4
);

// First stage: Generate and propagate signals
wire [3:0] G;
wire [3:0] P;
gen_propagate_stage #(4) gen_prop_stage1 (A, B, G, P);

// Second stage: Carry generation
wire [3:0] GG;
wire [3:0] GP;
gen_propagate_stage #(4) gen_prop_stage2 (G, P, GG, GP);

// Third stage: Carry propagate and generate outputs
wire [4:0] C;
assign C[0] = 0;
assign C[1] = P[0] | (G[0] & C[0]);
assign C[2] = GP[1] | (GG[1] & C[1]);
assign C[3] = GP[2] | (GG[2] & C[2]);
assign C4 = GG[3] | (GP[3] & C[3]);

// Sum computation
assign S = A + B + C[1:0];

endmodule

module gen_propagate_stage #(parameter N) (
  input [N-1:0] A,
  input [N-1:0] B,
  output [N-1:0] G,
  output [N-1:0] P
);

// Generate signals
assign G = A & B;

// Propagate signals
assign P = A | B;

endmodule