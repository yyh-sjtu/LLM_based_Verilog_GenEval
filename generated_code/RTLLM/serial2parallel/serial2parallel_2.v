
module serial2parallel (
    input clk,
    input rst_n,
    input din_serial,
    input din_valid,
    output reg [7:0] dout_parallel,
    output reg dout_valid
);

reg [3:0] cnt;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt <= 4'b0000;
        dout_parallel <= 8'b00000000;
        dout_valid <= 0;
    end else begin
        if (din_valid) begin
            if (cnt < 4'b1000) begin
                cnt <= cnt + 1;
                dout_parallel <= {din_serial, dout_parallel[7:1]};
            end else begin
                cnt <= 4'b0000;
                dout_valid <= 1;
            end
        end
    end
end

endmodule