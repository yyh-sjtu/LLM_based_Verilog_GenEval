module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

// Synchronize input signal with clock
reg a_sync;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        a_sync <= 1'b0;
    end else begin
        a_sync <= a;
    end
end

// Detect rising and falling edges
reg a_sync_prev;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        a_sync_prev <= 1'b0;
    end else begin
        a_sync_prev <= a_sync;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 1'b0;
        down <= 1'b0;
    end else begin
        if (a_sync && !a_sync_prev) begin
            rise <= 1'b1;
        end else if (!a_sync && a_sync_prev) begin
            down <= 1'b1;
        end else begin
            rise <= 1'b0;
            down <= 1'b0;
        end
    end
end

endmodule

