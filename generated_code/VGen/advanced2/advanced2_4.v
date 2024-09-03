module count_slow (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset the counter to 0
    end else begin
        if (slowena) begin // Check if slowena is high to count
            if (q == 4'b1001) begin
                q <= 4'b0000; // Reset the counter when it reaches 9
            end else begin
                q <= q + 1;  // Increment the counter
            end
        end
    end
end

endmodule

