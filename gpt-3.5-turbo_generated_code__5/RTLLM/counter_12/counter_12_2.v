
module counter_12 (
    input rst_n, // Reset signal (active low)
    input clk, // Clock signal
    input valid_count, // Signal to enable counting
    output reg [3:0] out // 4-bit output representing the current count value
);

always @(posedge clk or negedge rst_n)
begin
    if (!rst_n) // Reset signal is active
        out <= 4'b0000; // Reset the counter to 0
    else if (valid_count) // If valid_count signal is active
    begin
        if (out == 4'd11) // If current count value is 11
            out <= 4'b0000; // Reset counter to 0
        else
            out <= out + 1; // Increment the counter
    end
    // If valid_count signal is 0, the counter will stop and the count value remains unchanged
end

endmodule