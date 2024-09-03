
module width_8to16 (
    input clk,
    input rst_n,
    input valid_in,
    input [7:0] data_in,
    output reg valid_out,
    output reg [15:0] data_out
);

reg [7:0] data_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        valid_out <= 0;
        data_out <= 0;
        data_reg <= 0;
    end else begin
        if (valid_in) begin
            if (!valid_out) begin
                data_reg <= data_in;
                valid_out <= 1;
            end else begin
                data_out <= {data_reg, data_in};
                valid_out <= 0;
            end
        end
    end
end

endmodule