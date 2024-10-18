
module cla_16bit (
    input [15:0] A,
    input [15:0] B,
    input   C_in,
    output [15:0] S,
    output Cout
);

wire [15:0] Gi, Pi, Ci, Ci_max;
wire [15:0] G, P;
wire P_i, G_i;
wire C_in_i, C_out_i;

xor #(16) xor1 (
    .A(A[0]),
    .B(B[0]),
    .O(G_i)
);

and #(16) and1 (
    .A(A[0]),
    .B(B[0]),
    .O(P_i)
);

assign G[0] = G_i;
assign P[0] = P_i;

assign Ci[0] = C_in;
assign Ci_max[0] = C_in;

genvar i;

generate
    for (i = 1; i < 16; i=i+1) begin: generate_loop
        xor #(16) xor2 (
            .A(A[i]),
            .B(B[i]),
            .O(G[i])
        );

        xor #(16) xor3 (
            .A(A[i]),
            .B(P[i-1]),
            .O(G_i)
        );

        and #(16) and2 (
            .A(A[i]),
            .B(B[i]),
            .O(P[i])
        );

        or #(16) or1 (
            .A(G[i-1]),
            .B(P[i-1]),
            .O(P_i)
        );

        and #(16) and3 (
            .A(G[i-1]),
            .B(P[i-1]),
            .O(Ci[i])
        );

        and #(16) and4 (
            .A(G_i),
            .B(Ci_max[i-1]),
            .O(Ci[i-1])
        );

        or #(16) or2 (
            .A(Ci[i]),
            .B(Ci[i-1]),
            .O(Ci_max[i])
        );
    end
endgenerate

assign S = A + B + C_in;
assign Cout = Ci_max[15];

endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

wire [15:0] G [1:2];
wire [15:0] P [1:2];
wire [15:0] C [1:2];

genvar j;
generate
    for (j = 1; j <= 2; j=j+1) begin: generate_loop
        cla_16bit cla_inst (
            .A(A[(16*j) - 1 : 16*(j-1)]),
            .B(B[(16*j) - 1 : 16*(j-1)]),
            .C_in(C[j-1]),
            .S(S[(16*j) - 1 : 16*(j-1)]),
            .Cout(C[j])
        );
    end
endgenerate

assign C32 = C[2];

endmodule