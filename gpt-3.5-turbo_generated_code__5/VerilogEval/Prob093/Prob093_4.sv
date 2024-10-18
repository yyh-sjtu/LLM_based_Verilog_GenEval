
module TopModule(
    input c,
    input d,
    output [3:0] mux_in
);

wire ab0, ab1;
assign ab0 = 1'b0;  // ab = 00
assign ab1 = 1'b1;  // ab = 01

// Implementing the K-map using muxes
assign mux_in[0] = (c & d & ab0) | (~d & ab1);
assign mux_in[1] = (c & ~d & ab0) | (~c & ~d & ab1);
assign mux_in[2] = (c & ~d) | (~c & ab0) | (c & d & ab1);
assign mux_in[3] = (~c & d & ab0) | (c & d) | (c & ~d & ab1);

endmodule