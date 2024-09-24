
module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

wire [15:0] S0, S1;
wire [16:0] G, P;
wire [7:0] G0, G1, P0, P1;
wire [8:0] G_propagate, G_generate, P_generate;

CLA_16bit clablock0(
    .A(A[15:0]),
    .B(B[15:0]),
    .S(S0),
    .G(G0),
    .P(P0)
);

CLA_16bit clablock1(
    .A(A[31:16]),
    .B(B[31:16]),
    .S(S1),
    .G(G1),
    .P(P1)
);

generate
    assign G_propagate[7:0] = {G1[7] & P0[7], G1[6] & P0[6], G1[5] & P0[5], G1[4] & P0[4],
                               G1[3] & P0[3], G1[2] & P0[2], G1[1] & P0[1], G1[0] & P0[0]};
    
    assign G_generate[7:0] = {G1[7] | (P1[7] & G0[7]), G1[6] | (P1[6] & G0[6]),
                              G1[5] | (P1[5] & G0[5]), G1[4] | (P1[4] & G0[4]),
                              G1[3] | (P1[3] & G0[3]), G1[2] | (P1[2] & G0[2]),
                              G1[1] | (P1[1] & G0[1]), G1[0] | (P1[0] & G0[0])};
    
    assign P_generate = G1[7] | (P1[7] & G0[7]);

    assign C32 = G_generate[7] | (P_generate & G_propagate[7]);
endgenerate

assign S = {S1, S0};
    
endmodule