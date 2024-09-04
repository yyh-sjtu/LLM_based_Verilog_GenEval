
module TopModule(
    input clk,
    input reset,
    output reg [3:0] q
);

// Decade counter implementation
always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset counter to 0
    end else begin
        if (q == 4'b1001) begin
            q <= 4'b0000; // Reset counter to 0 when reaching 9
        end else begin
            q <= q + 1; // Increment counter
        end
    end
end

endmodule