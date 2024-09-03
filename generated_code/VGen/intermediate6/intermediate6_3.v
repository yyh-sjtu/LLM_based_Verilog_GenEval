module full_adder (
    input wire [15:0] A,
    input wire [15:0] B,
    input wire Cin,
    output wire [15:0] Sum,
    output wire Cout
);

wire [15:0] C, S1, S2;

xor_gate xor1 (.A(A), .B(B), .Y(S1));
xor_gate xor2 (.A(S1), .B(Cin), .Y(S2));
and_gate and1 (.A(S1), .B(Cin), .Y(C));
and_gate and2 (.A(A), .B(B), .Y(Cout));
or_gate or1 (.A(C, S2), .Y(Sum));

endmodule

