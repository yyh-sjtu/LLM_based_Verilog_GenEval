module TopModule(
    input clk,
    input x,
    output reg z
);
    reg d_FF1, d_FF2, d_FF3;
    wire d1, d2, d3;

    assign d1 = (d_FF1 == d_FF1) ? 1'b0 : 1'b1;
    assign d2 = ~d_FF2;
    assign d3 = ~d_FF3;

    always @(posedge clk) begin
        d_FF1 <= x ^ d_FF1;
        d_FF2 <= x & d_FF2;
        d_FF3 <= x | d_FF3;
        z <= ~(d1 ^ d2 ^ d3);
    end
endmodule

