
module count_slow(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

    // Always block triggered by the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        // Asynchronous reset
        if (reset) begin
            q <= 4'b0000;  // Reset q to 0
        end else if (slowena) begin
            // Increment the counter if slowena is high
            if (q == 4'b1001) begin
                q <= 4'b0000;  // Reset to 0 after reaching 9
            end else begin
                q <= q + 1;  // Increment the counter
            end
        end
    end

endmodule