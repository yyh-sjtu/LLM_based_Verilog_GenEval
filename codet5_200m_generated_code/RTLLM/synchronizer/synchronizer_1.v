module synchronizer (
    input clk_a,
    input clk_b,
    input arstn,
    input brstn,
    input [3:0] data_in,
    input data_en,
    output [3:0] dataout
);
    reg [3:0] dataout_reg;
    always @(posedge clk_a or negedge brstn)
        if(!brstn)
            dataout_reg <= 4'b0000;
        else if(data_en)
            dataout_reg <= data_in;
endmodule

