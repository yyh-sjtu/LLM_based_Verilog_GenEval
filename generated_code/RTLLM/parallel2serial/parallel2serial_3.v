
module parallel2serial(
    input clk,
    input rst_n,
    input [3:0] d,
    output reg valid_out,
    output reg dout
);

reg [2:0] cnt;
reg [3:0] data;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt <= 3'b0;
    end
    else begin
        if (cnt == 3'b11) begin
            data <= d;
            cnt <= 3'b0;
            valid_out <= 1;
        end
        else begin
            cnt <= cnt + 1;
            valid_out <= 0;
            data <= {data[2:0], data[3]};
        end
    end
end

always @(posedge clk) begin
    dout <= data[3];
end

endmodule