
module width_8to16 (
    input wire clk,
    input wire rst_n,
    input wire valid_in,
    input wire [7:0] data_in,
    output reg valid_out,
    output reg [15:0] data_out
);

reg [7:0] data_latch;
reg flag;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // reset condition
        data_latch <= 8'h00;
        valid_out <= 0;
        data_out <= 16'h0000;
        flag <= 0;
    end else begin
        if (valid_in) begin
            if (!flag) begin
                data_latch <= data_in;
                flag <= 1;
            end else begin
                valid_out <= 1;
                data_out <= {data_latch, data_in};
                flag <= 0;
            end
        end
    end
end

endmodule