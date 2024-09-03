module clacell(P,G,Cin,Sum,Co);
    input P,G,Cin;
    output Sum,Co;
    wire t1,t2,t3,t4;
    assign t1 = P & G;
    assign t2 = P ^ G;
    assign t3 = t2 & Cin;
    assign Sum = t2 ^ Cin;
    assign t4 = t1 | t3;
    assign Co = t4;

endmodule

module clacarry(Cin, P, G, Co);
    input Cin;
    output [1:0]P,G;
    output Co;
    assign P = Cin;
    assign G = Cin;
    assign Co = Cin;

endmodule

module clalevel(P, G, Cin, Sum, Co);
    input [3:0]P,G;
    input Cin;
    output [1:0]Sum;
    output Co;
    wire t1,t2,t3,t4;
    assign t1 = P[0] & G[0];
    assign t2 = P[1] & G[1];
    assign t3 = t1 | (t2 & P[0]) | (G[1] & G[0]);
    assign Sum[0] = P[0] ^ G[0] ^ Cin;
    assign Sum[1] = P[1] ^ G[1] ^ t3;
    assign t4 = t1 | (t2 & P[0]) | (G[1] & G[0]);
    assign Co = (t1 & G[1]) | (t2 & G[1]) | (t1 & P[0]);

endmodule

module adder_32bit(
    input [31:0]A,
    input [31:0]B,
    output [31:0]S,
    output C32
);

    wire [4:0]pArray, gArray;
    wire [1:0]sumArray2;
    wire [4:0]coArray;

    assign gArray[0] = 1'b0;
    genvar i;
    generate
        for (i=1;i<=4;i=i+1) begin: generateCells
            clacarry carry(
                .Cin(coArray[i-1]),
                .P(pArray[i]),
                .G(gArray[i]),
                .Co(coArray[i])
            );

            clacell cell(
                .P(pArray[i]),
                .G(gArray[i]),
                .Cin(A[i]),
                .Sum(S[i]),
                .Co(sumArray2[0])
            );

            clalevel level(
                .P({pArray[i-1], sumArray2[0]}),
                .G({gArray[i-1], 1'b0}),
                .Cin(coArray[i-1]),
                .Sum(sumArray2),
                .Co(coArray[i-1])
            );         
        end
    endgenerate

    assign C32 = coArray[4];
endmodule

