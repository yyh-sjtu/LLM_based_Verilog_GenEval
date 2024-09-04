
module TopModule (
    input  clk,
    input  reset,
    output reg [3:0] q // 4-bit output
);

// Always block that triggers on the positive edge of the clock
always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset to 1
    end else begin
        // Increment the counter
        if (q == 4'b1010) begin // If q reaches 10 (1010), reset to 1
            q <= 4'b0001;
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
end

endmodule