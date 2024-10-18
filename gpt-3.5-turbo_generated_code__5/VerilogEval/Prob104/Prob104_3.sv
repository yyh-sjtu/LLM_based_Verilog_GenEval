
module TopModule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output Q
);

reg [2:0] r1, r2, r3;
wire [2:0] q_out1, q_out2, q_out3;

full_module inst1 (
    .r({r_in, r1}),
    .L(L),
    .clk(clk),
    .q(q_out1)
);

full_module inst2 (
    .r({r_in, r2}),
    .L(L),
    .clk(clk),
    .q(q_out2)
);

full_module inst3 (
    .r({r_in, r3}),
    .L(L),
    .clk(clk),
    .q(q_out3)
);

assign Q = q_in | q_out1 | q_out2 | q_out3;

endmodule