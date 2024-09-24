module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output [64:0] result,
    output o_en
);
    reg [64:0] adda_reg;
    reg [64:0] addb_reg;
    reg [64:0] result_reg;
    reg o_en;
    always @(posedge clk or negedge rst_n)
    begin
        if (~rst_n)
            adda_reg <= 64'h0;
        else if (i_en)
            adda_reg <= adda;
    end
    always @(posedge clk or negedge rst_n)
    begin
        if (~rst_n)
            addb_reg <= 64'h0;
        else if (i_en)
            addb_reg <= addb;
    end
    assign result = result_reg;
    assign o_en = o_en;
endmodule

