
module TopModule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output Q
);

reg [2:0] r;
reg Q;

full_module full_inst1 (
    .r({r_in, r_in}),
    .L(L),
    .clk(clk),
    .q(r)
);

full_module full_inst2 (
    .r({r_in, r_in}),
    .L(L),
    .clk(clk),
    .q(r)
);

full_module full_inst3 (
    .r({r_in, r_in}),
    .L(L),
    .clk(clk),
    .q(r)
);

assign Q = r[2];

endmodule