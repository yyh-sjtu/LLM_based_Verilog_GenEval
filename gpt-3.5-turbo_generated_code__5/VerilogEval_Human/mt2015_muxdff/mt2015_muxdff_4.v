module flipflop(
    input clk,
    input L,
    input r,
    output reg q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

endmodule

module mux2to1(
    input a,
    input b,
    input sel,
    output reg out
);

always @* begin
    if (sel) begin
        out = b;
    end else begin
        out = a;
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

wire [2:0] r;
wire [2:0] q;

assign r = r_in;
assign q = q_in;

flipflop ff1(
    .clk(clk),
    .L(L),
    .r(r[0]),
    .q(q[0])
);

flipflop ff2(
    .clk(clk),
    .L(L),
    .r(r[1]),
    .q(q[1])
);

flipflop ff3(
    .clk(clk),
    .L(L),
    .r(r[2]),
    .q(q[2])
);

mux2to1 mux(
    .a(q[1] ^ q[2]),
    .b(q[0]),
    .sel(q[2]),
    .out(Q)
);

endmodule

