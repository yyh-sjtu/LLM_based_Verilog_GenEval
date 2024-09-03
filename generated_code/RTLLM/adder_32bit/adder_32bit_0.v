
module cla_16bit (
    input [15:0] A,
    input [15:0] B,
    output [15:0] S,
    output C_out
);

    assign generate = A & B;
    assign propagate = A | B;
    assign G = generate + propagate;
    
    // Generate majority function for each group of three bits
    assign P = (A & B) | (B & C_in) | (A & C_in);
    assign G = (A ^ B) & C_in;
    
    // Generate carry-out and sum
    assign S = A ^ B ^ C_in;
    assign C_out = G | (P & generate);
    
endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);

    wire [15:0] c_in;
    wire [15:0] c_out;
    
    cla_16bit cla1 (
        .A(A[15:0]),
        .B(B[15:0]),
        .S(S[15:0]),
        .C_out(c_in[0])
    );
    
    cla_16bit cla2 (
        .A(A[31:16]),
        .B(B[31:16]),
        .S(S[31:16]),
        .C_out(c_out[0])
    );
    
    assign S = {c_out, c_in};
    assign C32 = c_out[0];
    
endmodule