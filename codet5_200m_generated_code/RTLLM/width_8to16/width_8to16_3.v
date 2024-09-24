module width_8to16 (
    input clk,
    input rst_n,
    input valid_in,
    input [7:0] data_in,
    output valid_out,
    output [15:0] data_out
);
    reg [7:0] data_out_reg;
    assign valid_out = data_out_reg[7];
    assign data_out = data_out_reg[15:8];
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out_reg <= 16'h0;
            valid_out <= 1'b0;
        end else begin
            if (valid_in) begin
                data_out_reg <= data_in;
                valid_out <= valid_in;
            end
        end
    end
endmodule

