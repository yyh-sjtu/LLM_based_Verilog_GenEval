module dff (
    input clk,
    input d,
    output reg q
);

always @(posedge clk)
    q <= d;

endmodule

module xor2 (
    input a,
    input b,
    output y
);

assign y = a ^ b;

endmodule

module top_module (
    input clk,
    input in,
    output logic out
);

reg d;

xor2 xor_gate(
    .a(in),
    .b(out),
    .y(d)
);

dff flip_flop(
    .clk(clk),
    .d(d),
    .q(out)
);

endmodule

