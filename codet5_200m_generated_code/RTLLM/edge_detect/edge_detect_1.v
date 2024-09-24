module edge_detect (
    input clk,
    input rst_n,
    input a,
    output rise,
    output down
);
    reg [7:0] codes;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            codes <= 7'b0;
        else
            codes <= codes + 7'b1;
    assign rise = codes[7];
    assign down = codes[7];
endmodule

