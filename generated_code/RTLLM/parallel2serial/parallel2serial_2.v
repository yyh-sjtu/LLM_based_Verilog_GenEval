module parallel2serial(
    input clk,
    input rst_n,
    input [3:0] d,
    output reg valid_out,
    output reg dout
);

reg [3:0] data;
reg [1:0] cnt;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt <= 2'b00;
        valid_out <= 0;
        dout <= 1'b0;
        data <= 4'b0;
    end
    else begin
        if (cnt == 2'd3) begin
            cnt <= 2'b00;
            valid_out <= 1;
            dout <= data[3];
            data <= d;
        end
        else begin
            cnt <= cnt + 1;
            valid_out <= 0;
            dout <= data[3];
            data <= {data[2:0], 1'b0};
        end
    end
end

endmodule
