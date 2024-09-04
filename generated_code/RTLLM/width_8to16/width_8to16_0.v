
module width_8to16 (
    input clk,
    input rst_n,
    input valid_in,
    input [7:0] data_in,
    output reg valid_out,
    output reg [15:0] data_out
);

reg [7:0] data_reg;
reg [7:0] data_lock;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        data_reg <= 8'b0;
        data_lock <= 8'b0;
        valid_out <= 0;
        data_out <= 16'b0;
    end else begin
        if (valid_in) begin
            data_lock <= data_reg;
            data_reg <= data_in;
        end
        if (valid_in && ~valid_out) begin
            valid_out <= 1;
            data_out <= {data_lock, data_in};
        end
    end
end

endmodule