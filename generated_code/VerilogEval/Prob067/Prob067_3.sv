
module TopModule (
    input  wire clk,       // Clock input
    input  wire reset,     // Synchronous reset input
    input  wire slowena,   // Enable signal for slow counting
    output reg  [3:0] q    // 4-bit output for the counter
);

// Synchronous reset and counting logic
always @(posedge clk) begin
    if (reset) begin
        // Reset the counter to 0 if reset is high
        q <= 4'b0000;
    end else if (slowena) begin
        // Increment the counter on each clock cycle if slowena is high
        if (q == 4'b1001) begin
            q <= 4'b0000; // Reset to 0 after reaching 9
        end else begin
            q <= q + 1'b1; // Increment the counter
        end
    end
end

endmodule