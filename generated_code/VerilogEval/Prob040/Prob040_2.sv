
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

    // Sequential logic to describe the behavior of the decade counter
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  // Reset the counter to 0
        end else begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Reset to 0 after reaching 9
            end else begin
                q <= q + 1;   // Increment the counter
            end
        end
    end

endmodule