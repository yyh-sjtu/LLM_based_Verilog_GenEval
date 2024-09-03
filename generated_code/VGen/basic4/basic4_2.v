module full_adder(
    input [15:0] a, b, cin,
    output [15:0] sum, cout
);

wire [15:0] c1, c2, c3;

xor_gate xor1(.in1(a), .in2(b), .out(c1));
xor_gate xor2(.in1(c1), .in2(cin), .out(sum));

and_gate and1(.in1(a), .in2(b), .out(c2));
and_gate and2(.in1(b), .in2(cin), .out(c3));
and_gate and3(.in1(c1), .in2(cin), .out(cout));
or_gate or1(.in1(c2), .in2(c3), .out(cout));

endmodule

module xor_gate(
    input [15:0] in1, in2,
    output [15:0] out
);

assign out = in1 ^ in2;

endmodule

module and_gate(
    input [15:0] in1, in2,
    output [15:0] out
);

assign out = in1 & in2;

endmodule

module or_gate(
    input [15:0] in1, in2,
    output [15:0] out
);

assign out = in1 | in2;

endmodule

