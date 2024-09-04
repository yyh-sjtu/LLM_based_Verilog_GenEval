
module TopModule (
    input  wire clk,       // Clock input
    input  wire reset,     // Synchronous reset input
    output reg  [9:0] q    // 10-bit output for the counter
);

    // Counter parameter
    parameter MAX_COUNT = 10'd999;

    // Always block for synchronous logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset the counter to 0
            q <= 10'b0;
        end else begin
            // Increment the counter unless it has reached the maximum
            if (q < MAX_COUNT) begin
                q <= q + 1'b1;
            end else begin
                q <= 10'b0; // Reset to 0 if it exceeds 999
            end
        end
    end

endmodule