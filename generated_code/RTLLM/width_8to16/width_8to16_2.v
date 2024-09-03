
module width_8to16(
    input clk,
    input rst_n,
    input valid_in,
    input [7:0] data_in,
    output reg valid_out,
    output reg [15:0] data_out
);

reg [7:0] data_reg;
reg flag;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 16'h0000;
        valid_out <= 1'b0;
        flag <= 1'b0;
    end else begin
        if (valid_in && !flag) begin
            data_reg <= data_in;
            flag <= 1'b1;
        end else if (valid_in && flag) begin
            data_out <= {data_reg, data_in};
            valid_out <= 1'b1;
            flag <= 1'b0;
        end
    end
end

endmodule