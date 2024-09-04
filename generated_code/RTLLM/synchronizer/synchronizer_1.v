
module synchronizer (
    input clk_a,
    input clk_b,
    input arstn,
    input brstn,
    input [3:0] data_in,
    input data_en,
    output reg [3:0] dataout
);

reg [3:0] data_reg;
reg en_data_reg;
reg en_clap_one;
reg en_clap_two;

always @(posedge clk_a or negedge arstn) begin
    if (~arstn) begin
        data_reg <= 4'b0000;
    end else begin
        data_reg <= data_in;
    end
end

always @(posedge clk_a or negedge arstn) begin
    if (~arstn) begin
        en_data_reg <= 1'b0;
    end else begin
        en_data_reg <= data_en;
    end
end

always @(posedge clk_b or negedge brstn) begin
    if (~brstn) begin
        en_clap_one <= 1'b0;
        en_clap_two <= 1'b0;
    end else begin
        en_clap_one <= en_data_reg;
        en_clap_two <= en_clap_one;
    end
end

always @(posedge clk_b or negedge brstn) begin
    if (~brstn) begin
        dataout <= 4'b0000;
    end else begin
        if (en_clap_two) begin
            dataout <= data_reg;
        end
    end
end

endmodule