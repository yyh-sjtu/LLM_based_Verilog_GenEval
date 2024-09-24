module JC_counter (
    input clk,
    input rst_n,
    output [63:0] Q
);
    reg [63:0] r;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            r <= 64'h0;
        else
            r <= r + 1'b1;
    assign Q = r;
endmodule

