
module TopModule (
    input  clk,
    input  reset,
    output reg [3:0] q // 4-bit output
);

// Always block triggered on the positive edge of the clock or when reset is high
always @(posedge clk) begin
    if (reset) begin
        // Reset counter to 0
        q <= 4'b0000;
    end else begin
        // Increment counter; wrap around to 0 after reaching 15
        q <= q + 1;
    end
end

endmodule