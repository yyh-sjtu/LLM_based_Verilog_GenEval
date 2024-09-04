
module TopModule (
    input clk,
    input a,
    output reg [2:0] q
);

// Sequential logic
always @(posedge clk) begin
    if (a) begin
        q <= (q + 1) % 8; // Increment q and wrap around at 8 (since it's 3 bits)
    end else begin
        q <= 0; // Reset to 0 when a is 0
    end
end

endmodule