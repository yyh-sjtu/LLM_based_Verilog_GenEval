module flipflop_2to1_mux (
    input clk,
    input L,
    input [2:0] r,
    input q_in,
    output reg [2:0] q_out
);

reg [2:0] q_ff;

always @(posedge clk) begin
    if (L) begin
        q_ff <= r;
    end else begin
        q_ff <= {q_ff[1] ^ q_ff[2], q_ff[0], q_ff[2]};
    end
end

always @* begin
    if (q_in) begin
        q_out <= q_ff;
    end else begin
        q_out <= r;
    end
end

endmodule

module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

flipflop_2to1_mux ff_mux_inst1 (
    .clk(clk),
    .L(L),
    .r(r_in),
    .q_in(q_in),
    .q_out(Q)
);

flipflop_2to1_mux ff_mux_inst2 (
    .clk(clk),
    .L(L),
    .r(r_in),
    .q_in(Q),
    .q_out(Q)
);

flipflop_2to1_mux ff_mux_inst3 (
    .clk(clk),
    .L(L),
    .r(r_in),
    .q_in(Q),
    .q_out(Q)
);

endmodule

