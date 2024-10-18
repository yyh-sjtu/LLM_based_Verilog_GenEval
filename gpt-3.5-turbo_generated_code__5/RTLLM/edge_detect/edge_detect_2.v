
module edge_detect (
    input wire clk,
    input wire rst_n,
    input wire a,
    output reg rise,
    output reg down
);

// Synchronize the input signal with the clock
reg a_sync;
reg a_sync_prev;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        a_sync <= 1'b0;
        a_sync_prev <= 1'b0;
    end else begin
        a_sync <= a;
        a_sync_prev <= a_sync;
    end
end

// Detect rising and falling edges
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 1'b0;
        down <= 1'b0;
    end else begin
        if (a_sync && !a_sync_prev) begin
            rise <= 1'b1;
        end else begin
            rise <= 1'b0;
        end
        
        if (!a_sync && a_sync_prev) begin
            down <= 1'b1;
        end else begin
            down <= 1'b0;
        end
    end
end

endmodule