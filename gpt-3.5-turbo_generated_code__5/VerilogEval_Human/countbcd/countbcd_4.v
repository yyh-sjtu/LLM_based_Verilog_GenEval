module top_module(
    input clk,       // Clock input
    input reset,     // Reset input
    output [3:1] ena,   // Enable signals
    output reg [15:0] q  // 4-digit BCD counter output
);

reg [15:0] q_next;   // Next state of the counter

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 16'b0;   // Reset the counter
    end else begin
        q <= q_next;   // Update the counter with the next state
    end
end

always @* begin
    ena = q[15:13];   // Enable signals for the upper three digits
    q_next = q + 1;   // Increment the counter
end

endmodule

