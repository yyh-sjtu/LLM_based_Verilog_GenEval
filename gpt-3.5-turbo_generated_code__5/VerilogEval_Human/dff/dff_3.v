module d_flip_flop(
    input clk,
    input d,
    output reg q
);

always @(posedge clk)
    q <= d;

endmodule

module top_module(
    input clk,
    input d,
    output reg q
);

d_flip_flop dff(.clk(clk), .d(d), .q(q));

endmodule

