
module count_slow (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0; // Resets the counter to 0
    end else begin
        if (slowena) begin
            if (q == 4'b1001) begin
                q <= 4'b0; // Reset to 0 once it reaches 9
            end else begin
                q <= q + 1; // Increment the counter
            end
        end
    end
end

endmodule