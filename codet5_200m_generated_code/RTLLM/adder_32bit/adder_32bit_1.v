module adder_32bit (
	input [32:1] A,
	input [32:1] B,
	output [32:1] S,
	output C32
);
    CLACLA I0 (A, B, S);
    assign C32 = S[31];
endmodule

