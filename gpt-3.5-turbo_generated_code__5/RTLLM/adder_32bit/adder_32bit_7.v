module cla_16bit (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] S,
    output Cout
);

    wire [3:0] G, P;
    
    assign G[0] = A[0] & B[0];
    assign P[0] = A[0] | B[0];
    
    assign G[1] = A[1] & B[1] | G[0] & P[0];
    assign P[1] = A[1] | B[1];
    
    assign G[2] = A[2] & B[2] | G[1] & P[1];
    assign P[2] = A[2] | B[2];
    
    assign G[3] = A[3] & B[3] | G[2] & P[2];
    assign P[3] = A[3] | B[3];
    
    assign S[0] = A[0] ^ B[0] ^ Cin;
    assign S[1] = A[1] ^ B[1] ^ G[0];
    assign S[2] = A[2] ^ B[2] ^ G[1];
    assign S[3] = A[3] ^ B[3] ^ G[2];
    
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

    wire [15:0] Cout;
    wire [31:0] C;
    
    cla_16bit cla0 (
        .A(A[15:0]),
        .B(B[15:0]),
        .Cin(1'b0),
        .S(S[15:0]),
        .Cout(Cout[0])
    );
    
    cla_16bit cla1 (
        .A(A[31:16]),
        .B(B[31:16]),
        .Cin(Cout[0]),
        .S(S[31:16]),
        .Cout(C32)
    );

endmodule

