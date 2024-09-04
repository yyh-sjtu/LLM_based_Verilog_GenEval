
module counter(
    input clk,
    input reset,
    output reg [3:0] q
);

    // Initialize the counter to 1
    initial begin
        q = 4'b0001;  // Start at 1
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0001;  // Reset the counter to 1
        end else begin
            if (q == 4'b1100) begin  // If counter reached 12 (1100 in binary)
                q <= 4'b0001;  // Reset to 1
            end else begin
                q <= q + 1;  // Increment the counter
            end
        end
    end
endmodule