
module counter_12(
    input rst_n, // Reset signal (active low)
    input clk,   // Clock signal
    input valid_count, // Signal to enable counting
    output reg [3:0] out // 4-bit output representing the current count value
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= 4'b0000; // Reset the counter to 0
        end else begin
            if (valid_count) begin
                if (out == 4'd11) begin
                    out <= 4'b0000; // Wrap around when maximum count value is reached
                end else begin
                    out <= out + 1; // Increment the counter
                end
            end
            // If valid_count is 0, the counter pauses
        end
    end

endmodule