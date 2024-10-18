
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

// Syncing reset signal
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 0;
        down <= 0;
    end
end

// Edge detection logic
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 0;
        down <= 0;
    end else if (a & !$past(a)) begin
        rise <= 1;
        down <= 0;
    end else if (!a & $past(a)) begin
        rise <= 0;
        down <= 1;
    end else begin
        rise <= 0;
        down <= 0;
    end
end

endmodule