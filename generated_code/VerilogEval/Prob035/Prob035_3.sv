
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

// Initial state for the counter
initial begin
    q = 4'b0001; // Start counting from 1
end

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset the counter to 1
    end else begin
        if (q == 4'b1010) begin // Check if q has reached 10
            q <= 4'b0001; // Wrap around to 1
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
end

endmodule