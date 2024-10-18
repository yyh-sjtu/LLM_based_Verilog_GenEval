module flipflop_mux(
    input clk,
    input L,
    input [2:0] r,
    input q_in,
    output reg [2:0] q_out
);

always @(posedge clk) begin
    if (L) begin
        q_out <= r;
    end else begin
        q_out <= {q_in[1] ^ q_in[2], q_in[0], q_in[2]};
    end
end

endmodule

module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] q_out_1;
wire [2:0] q_out_2;
wire [2:0] q_out_3;

flipflop_mux flipflop_mux_1(
    .clk(clk),
    .L(L),
    .r(r_in),
    .q_in(q_in),
    .q_out(q_out_1)
);

flipflop_mux flipflop_mux_2(
    .clk(clk),
    .L(L),
    .r(r_in),
    .q_in(q_out_1),
    .q_out(q_out_2)
);

flipflop_mux flipflop_mux_3(
    .clk(clk),
    .L(L),
    .r(r_in),
    .q_in(q_out_2),
    .q_out(q_out_3)
);

assign Q = q_out_3[0];

endmodule

