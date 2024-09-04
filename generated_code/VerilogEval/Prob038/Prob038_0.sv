
module TopModule (
    input  clk,        // Clock input
    input  reset,      // Reset input (active high)
    output reg [3:0] q // Output 4-bit counter
);

// Always block triggered on the positive edge of the clock
always @(posedge clk) begin
    if (reset) begin
        // Reset counter to 0 on active high reset
        q <= 4'b0000; 
    end else begin
        // Increment the counter, wrap around at 16
        q <= (q + 1) & 4'b1111; // & 4'b1111 ensures the counter wraps around to 0 after 15
    end
end

endmodule