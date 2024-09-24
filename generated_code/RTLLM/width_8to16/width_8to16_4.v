
module width_8to16 (
    input clk,
    input rst_n,
    input valid_in,
    input [7:0] data_in,
    output reg valid_out,
    output reg [15:0] data_out
);

reg [15:0] data_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_reg <= 16'b0;
        valid_out <= 0;
    end else begin
        if (valid_in) begin
            if (!valid_out) begin
                data_reg <= {data_in, 8'b0};
                valid_out <= 0;
            end else begin
                data_reg <= {data_reg[15:8], data_in};
                valid_out <= 1;
            end
        end
    end
end

assign data_out = data_reg;

endmodule