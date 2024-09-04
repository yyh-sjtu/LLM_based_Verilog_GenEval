
module counter(
    input clk,
    input reset,
    output reg [3:0] q
);

// Initialize the counter
initial begin
    q = 4'b0001; // Start from 1
end

// Always block triggered on positive edge of clk or reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0001; // Reset the counter to 1
    end else begin
        if (q == 4'b1100) begin // Check if counter reaches 12
            q <= 4'b0001; // Reset to 1
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
end

endmodule