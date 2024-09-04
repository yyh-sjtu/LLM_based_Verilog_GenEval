
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
        dout_valid <= 0;
    end
    else if (din_valid) begin
        cnt <= cnt + 1;
        if (cnt == 4'b1000) begin
            dout_parallel <= {dout_parallel[6:0], din_serial};
            dout_valid <= 1;
            cnt <= 4'b0000;
        end
    end
end

endmodule