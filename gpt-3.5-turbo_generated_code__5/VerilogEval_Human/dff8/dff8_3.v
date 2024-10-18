module dff(
    input clk,
    input d,
    output reg q
);

    always @(posedge clk) 
        q <= d;

endmodule

module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    wire [7:0] d_out;

    dff dff0 (.clk(clk), .d(d[0]), .q(d_out[0]));
    dff dff1 (.clk(clk), .d(d[1]), .q(d_out[1]));
    dff dff2 (.clk(clk), .d(d[2]), .q(d_out[2]));
    dff dff3 (.clk(clk), .d(d[3]), .q(d_out[3]));
    dff dff4 (.clk(clk), .d(d[4]), .q(d_out[4]));
    dff dff5 (.clk(clk), .d(d[5]), .q(d_out[5]));
    dff dff6 (.clk(clk), .d(d[6]), .q(d_out[6]));
    dff dff7 (.clk(clk), .d(d[7]), .q(d_out[7]));

    always @(*)
        q = d_out;

endmodule

