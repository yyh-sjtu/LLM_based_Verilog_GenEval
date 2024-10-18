
module JC_counter(
    input clk,      // Clock signal
    input rst_n,    // Active-low reset signal
    output reg [63:0] Q   // 64-bit counter register
);

// Reset condition
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n) // Reset condition
        Q <= 64'd0;
    else
    begin
        // Counter logic
        if (Q[0] == 1'b0) // If LSB is 0, increment
            Q <= {Q[63:1], 1'b1};
        else // If LSB is 1, decrement
            Q <= {Q[63:1], 1'b0};
    end
end

endmodule