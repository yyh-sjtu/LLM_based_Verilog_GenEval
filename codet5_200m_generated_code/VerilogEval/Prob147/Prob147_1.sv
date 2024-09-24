module TopModule (
    input clk,
    input a,
    input b,
    output q,
    output state
);
    reg [3:0] state;
    reg [3:0] q;
    always @(posedge clk)
        q <= a & b;
    always @(posedge clk)
        state <= q;
endmodule

