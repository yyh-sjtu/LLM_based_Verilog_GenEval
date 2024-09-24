module TopModule (
    input  clk,
    input  resetn,
    input  [2:0] r,
    output [2:0] g
);
    reg [2:0] r_reg;
    reg [2:0] g_reg;
    always @(posedge clk or negedge resetn)
    begin
        if (~resetn)
            r_reg <= 0;
        else
            r_reg <= r;
    end
    assign g = r_reg[2];
    always @(posedge clk or negedge resetn)
    begin
        if (~resetn)
            g_reg <= 0;
        else
            g_reg <= g_reg;
    end
endmodule

