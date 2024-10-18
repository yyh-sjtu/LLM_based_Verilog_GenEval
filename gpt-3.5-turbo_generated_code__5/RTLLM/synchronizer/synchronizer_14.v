
module synchronizer (
    input wire clk_a,
    input wire clk_b,
    input wire arstn,
    input wire brstn,
    input wire [3:0] data_in,
    input wire data_en,
    output reg [3:0] dataout
);

reg [3:0] data_reg;
reg en_data_reg;
reg en_clap_one;
reg en_clap_two;

// Data Register
always @(posedge clk_a or negedge arstn) begin
    if (~arstn) begin
        // Reset condition
        data_reg <= 4'b0;
    end else begin
        // Update the register with data_in
        data_reg <= data_in;
    end
end

// Enable Data Register
always @(posedge clk_a or negedge arstn) begin
    if (~arstn) begin
        // Reset condition
        en_data_reg <= 1'b0;
    end else begin
        // Update the register with data_en
        en_data_reg <= data_en;
    end
end

// Enable Control Registers
always @(posedge clk_b or negedge brstn) begin
    if (~brstn) begin
        // Reset condition
        en_clap_one <= 1'b0;
        en_clap_two <= 1'b0;
    end else begin
        // Update the registers based on en_data_reg
        en_clap_one <= en_data_reg;
        en_clap_two <= en_clap_one;
    end
end

// Output Assignment
always @(posedge clk_b or negedge brstn) begin
    if (~brstn) begin
        // Reset condition
        dataout <= 4'b0;
    end else begin
        // Assign the output data value
        if (en_clap_two) begin
            dataout <= data_reg;
        end
    end
end

endmodule