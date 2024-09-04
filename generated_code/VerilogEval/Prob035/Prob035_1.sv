
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset counter to 1
    end else begin
        if (q == 10) begin
            q <= 4'b0001; // Reset counter to 1 when reaching 10
        end else begin
            q <= q + 4'b0001; // Increment counter
        end
    end
end

endmodule