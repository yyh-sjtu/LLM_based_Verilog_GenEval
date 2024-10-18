
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output rise,
    output down
);

reg a_prev;
reg rise_sync, down_sync;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        a_prev <= 0;
        rise_sync <= 0;
        down_sync <= 0;
    end else begin
        a_prev <= a;
        rise_sync <= (a && ~a_prev);
        down_sync <= (~a && a_prev);
    end
end

always @(posedge clk) begin
    if (~rst_n) begin
        rise <= 0;
        down <= 0;
    end else begin
        rise <= rise_sync;
        down <= down_sync;
    end
end

endmodule