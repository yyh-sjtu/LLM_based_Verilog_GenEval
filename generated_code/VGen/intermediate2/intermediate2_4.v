module counter(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset to 1
    end else begin
        if (q == 4'b1100) begin // Check if q is equal to 12
            q <= 4'b0001; // Reset to 1
        end else begin
            q <= q + 1; // Increment by 1
        end
    end
end

endmodule

