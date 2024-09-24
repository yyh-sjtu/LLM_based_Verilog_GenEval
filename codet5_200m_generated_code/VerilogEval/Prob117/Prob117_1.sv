module TopModule (
    input clk,
    input a,
    output [2:0] q
);
    reg [2:0] q;
    always @(posedge clk)
        q <= a;
endmodule

